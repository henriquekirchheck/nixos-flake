{ self, den, ... }:
{
  den.aspects.globals = {
    nixos.system.stateVersion = "26.11";
    homeManager.home.stateVersion = "26.11";
    nixpkgs-substituters = _: [
      {
        substituter = "https://henriquekh.cachix.org";
        public-key = "henriquekh.cachix.org-1:i7FaksyOcbvWqd6tdLHOO0/XfWCLRbk2P1nc94JcPlg=";
      }
      {
        substituter = "https://nix-community.cachix.org";
        public-key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      }
    ];
  };
  den.default.includes = [ den.aspects.globals ];
  perSystem = { pkgs, ... }: {
    files.file = {
      ".gitignore".text = ''
        /result
        .direnv/
        .pre-commit-config.yaml
      '';
      ".envrc".text = ''
        # shellcheck shell=bash
        use flake
      '';
      "README.md".text = ''
        # Dentritic NixOS Configuration
      '';
      "LICENSE".source = "${pkgs.common-licenses}/share/common-licenses/GPL-3";

      ".sops.yaml".source = self.lib.toSops pkgs "sops.yaml" rec {
        keys = {
          users.lina = "age129qafr4na6saelysulf4pf5ax43cj4jg6lg8wa7g7ex9ahtcvefqes6lxp";
          hosts.artemis = "age1zpmvfcsynflufcrgj3v9qlsq5cyl00xgf3vm6gkf2nuwdwcra4fq7pkc42";
          hosts.athena = "age1tvz9sv3mkmlad0esyfp6exrmqa7lrz938xp0z6f2hr0c8l9l9smq2den52";
        };
        rules = {
          artemis = {
            path_regex = "modules/hosts/artemis/secrets.yaml$";
            key_groups = [
              {
                age = [
                  keys.hosts.artemis
                  keys.users.lina
                ];
              }
            ];
          };
          athena = {
            path_regex = "modules/hosts/athena/secrets.yaml$";
            key_groups = [
              {
                age = [
                  keys.hosts.athena
                  keys.users.lina
                ];
              }
            ];
          };
          lina = {
            path_regex = "modules/users/lina/secrets.yaml$";
            key_groups = [
              {
                age = [
                  keys.users.lina
                  keys.hosts.artemis
                  keys.hosts.athena
                ];
              }
            ];
          };
        };
      };
    };
  };
}
