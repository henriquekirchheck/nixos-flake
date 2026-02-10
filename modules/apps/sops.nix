{ inputs, ... }:
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.apps.provides.sops =
    let
      defaultSopsFile = pkgs: pkgs.writeText "secrets.yaml" "";
    in
    {
      description = "Sops Nix";
      nixos =
        { pkgs, ... }:
        {
          imports = [ inputs.sops-nix.nixosModules.sops ];
          sops = {
            defaultSopsFile = defaultSopsFile pkgs;
            age = {
              keyFile = "/var/lib/sops-nix/key.txt";
              generateKey = true;
            };
          };
        };
      homeManager =
        { config, pkgs, ... }:
        {
          imports = [ inputs.sops-nix.homeManagerModules.sops ];
          sops = {
            defaultSopsFile = defaultSopsFile pkgs;
            age = {
              keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
            };
          };
        };
    };
}
