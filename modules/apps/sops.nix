{ inputs, ... }:
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.apps.provides.sops = {
    description = "Sops Nix";
    nixos = {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      sops.age = {
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
    homeManager =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];
        sops.age = {
          keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        };
      };
  };
}
