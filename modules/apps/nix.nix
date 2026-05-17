{ inputs, ... }:
{
  flake-file.inputs = {
    determinate-nix = {
      url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-23-11.follows = "nixpkgs";
        nixpkgs-regression.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks-nix.follows = "git-hooks-nix";
      };
    };
  };

  den.aspects.apps.provides.nix = {
    description = "Nix";
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        nix = {
          package =
            inputs.determinate-nix.packages."${pkgs.stdenv.hostPlatform.system}".default.overrideAttrs
              (_: {
                doCheck = false;
              });
          # package = pkgs.lix;
          settings = {
            auto-optimise-store = true;
            experimental-features = [
              "nix-command"
              "flakes"
              "pipe-operators"
            ];
            use-xdg-base-directories = true;
            diff-hook = lib.getExe pkgs.dix;
            run-diff-hook = true;
            eval-cores = 0;
            max-jobs = "auto";
            lazy-trees = true;
          };
          registry = {
            nixpkgs.flake = inputs.nixpkgs;
            home-manager.flake = inputs.home-manager;
            blender-bin.flake = inputs.blender-bin;
            disko.flake = inputs.disko;
            emacs-overlay.flake = inputs.emacs-overlay;
            flake-parts.flake = inputs.flake-parts;
            nur.flake = inputs.nur;
            sops-nix.flake = inputs.sops-nix;
            systems.flake = inputs.systems;
            nixos-config.flake = inputs.self;
          };
          channel.enable = false;
          nixPath = [
            "nixpkgs=flake:nixpkgs"
            "home-manager=flake:home-manager"
            "blender-bin=flake:blender-bin"
            "disko=flake:disko"
            "emacs-overlay=flake:emacs-overlay"
            "flake-parts=flake:flake-parts"
            "nur=flake:nur"
            "sops-nix=flake:sops-nix"
            "systems=flake:systems"
            "nixos-config=flake:nixos-config"
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
    homeManager.nix.package = null;

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
