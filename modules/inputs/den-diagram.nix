{
  den,
  lib,
  inputs,
  ...
}:
let
  diagram = inputs.den-diagram.lib;
  render = diagram.renderers { };

  # One pipeline run for the whole flake: every scope, host and user.
  fleetCapture = den.lib.capture.captureFleet { };

  hosts = lib.concatMap builtins.attrValues (builtins.attrValues den.hosts);

  hostViews =
    host:
    let
      # Cut one host's subtree out of the fleet capture.
      g = diagram.projectScope {
        inherit fleetCapture;
        kind = "host";
        inherit (host) name;
        direction = "TD";
      };
    in
    {
      "${host.name}-aspects" = render.toMermaid (diagram.graph.aspectsOnly g);
      "${host.name}-nixos" = render.toMermaid (diagram.graph.classSlice "nixos" g);
    };
in
{
  flake-file.inputs.den-diagram = {
    url = "github:denful/den-diagram";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.diagrams = {
    scope-topology = render.toScopeTopologyMermaid fleetCapture;
    policy-resolution = render.toPolicyResolutionMapMermaid fleetCapture;
    pipe-flow = render.toPipeFlowMermaid fleetCapture;
    pipe-sequence = render.toPipeSequenceMermaid fleetCapture;
  }
  // lib.mergeAttrsList (map hostViews hosts);

  perSystem =
    { pkgs, ... }:
    let
      rc = diagram.renderContext {
        inherit pkgs;
        theme = diagram.themeFromBase16 {
          inherit pkgs;
          scheme = "catppuccin-mocha";
        };
        mermaidConfig.layout = "elk";
      };

      hostEntries = lib.concatMap (
        host:
        diagram.export.entityEntries { inherit pkgs rc; } {
          inherit (host) name;
          entity = diagram.projectScope {
            inherit fleetCapture;
            kind = "host";
            inherit (host) name;
          };
          dir = "hosts/${host.name}";
          viewDefs =
            rc.views.host
            ++ rc.views.classViews [
              "nixos"
              "homeManager"
            ];
        }
      ) hosts;
    in
    {
      legacyPackages.diagrams = diagram.export.entriesToPackages hostEntries // {
        write-diagrams = diagram.export.mkWriteScript pkgs {
          entries = hostEntries;
          destExpr = ''"$(${pkgs.git}/bin/git rev-parse --show-toplevel)"'';
        };
      };
    };
}
