{ inputs, ... }:
{
  den.aspects.apps.provides.nix = {
    description = "Nix";
    nixos =
      { pkgs, lib, ... }:
      {
        nix = {
          package = pkgs.lix;
          settings = {
            auto-optimise-store = true;
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            use-xdg-base-directories = true;
            diff-hook = lib.getExe pkgs.dix;
            run-diff-hook = true;
          };
          registry = {
            nixpkgs.flake = inputs.nixpkgs;
            home-manager.flake = inputs.home-manager;
            nixos-config.flake = inputs.self;
          };
          channel.enable = false;
          nixPath = [
            "nixpkgs=${inputs.nixpkgs}"
            "home-manager=${inputs.home-manager}"
            "nixos-config=${inputs.self}"
            "${inputs.nixpkgs}"
          ];
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
          };
        };
        environment.shellAliases.nixrepl = "nix repl --expr 'builtins.getFlake \"${inputs.self}\"'";
      };
    provides.trusted-user =
      { user, ... }:
      {
        description = "Make the user a Nix trusted user";
        nixos = {
          nix.settings.trusted-users = [ user.userName ];
        };
      };
  };
}
