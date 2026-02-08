{
  inputs,
  den,
  ...
}:
{
  den.default.includes = [ den.aspects.disko ];
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.disko = den.lib.take.exactly (
    { OS, host }:
    let
      diskoClass = "disko";
      diskoModule =
        let
          aspect = OS { inherit OS host; };
        in
        aspect.resolve { class = diskoClass; };
    in
    {
      description = ''
        integrates disko into nixos OS classes.

        usage:

          for aspectssing disko in just a particular host:

          den.aspects.my-laptop.includes = [ den.aspects.disko ];

          for aspectsnabling disko by default on all hosts:

          den.default.includes = [ den.aspects.disko ];

        Does nothing for hosts that have no aspects with `${diskoClass}` class.
        Expects `inputs.disko` to exist.

        For each host resolves den.aspects.''${host.aspect} and imports its disko class module.
      '';

      nixos.imports = [
        inputs.disko."${host.class}Modules".disko
        diskoModule
      ];
    }
  );
}
