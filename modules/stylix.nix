{
  lib,
  den,
  inputs,
  ...
}:
{
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.default.includes = [ den.aspects.stylix ];

  den.aspects.stylix = den.lib.take.exactly (
    { HM-OS-HOST }:
    let
      inherit (HM-OS-HOST) OS host;

      stylixClass = "stylix";
      stylixModule =
        let
          aspect = OS { inherit OS host; };
        in
        aspect.resolve { class = stylixClass; };
    in
    {
      description = ''
        integrates stylix into nixos/darwin OS classes.

        usage:

          for using stylix in just a particular host:

          den.aspects.my-laptop.includes = [ den.aspects.stylix ];

          for enabling stylix by default on all hosts:

          den.default.includes = [ den.aspects.stylix ];

        Does nothing for hosts that have no users with `stylix` class.
        For each user resolves den.aspects.''${user.aspect} and imports its stylix config.
      '';

      ${host.class} = {
        imports = [
          inputs.stylix."${host.class}Modules".stylix
          stylixModule
        ];
        stylix.homeManagerIntegration = {
          followSystem = true;
          autoImport = true;
        };
      };
    }
  );
}
