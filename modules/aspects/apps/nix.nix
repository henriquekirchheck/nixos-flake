{ den, ... }:
{
  den.default.includes = [ den.aspects.apps.nix ];
  den.aspects.apps.nix = {
    nixos =
      {
        pkgs,
        lib,
        ...
      }:
      {
        nix = {
          package = pkgs.nixVersions.git;
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
            max-jobs = "auto";
          };
          channel.enable = false;
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
          };
        };
      };

    persistHome = _: {
      directories = [ ".local/share/nix" ];
    };
  };
  den.aspects.apps.nix.trusted-user =
    { user, ... }:
    {
      description = "Make the user a Nix trusted user";
      nixos.nix.settings.trusted-users = [ user.userName ];
    };
}
