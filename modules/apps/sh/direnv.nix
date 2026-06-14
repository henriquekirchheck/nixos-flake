{
  den.aspects.apps.provides.sh.provides.direnv = {
    description = "Direnv";

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs = {
          direnv = {
            enable = true;
            enableZshIntegration = false;
            enableBashIntegration = true;
            nix-direnv.enable = true;
          };
          zsh.plugins = [
            {
              name = "direnv";
              src = pkgs.runCommand "direnv-hook-zsh" { } ''
                mkdir -p "$out/share/direnv"
                ${lib.getExe config.programs.direnv.package} hook zsh > "$out/share/direnv/hook.zsh"
              '';
              file = "share/direnv/hook.zsh";
            }
          ];
        };
      };
  };
}
