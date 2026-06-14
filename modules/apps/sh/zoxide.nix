{
  den.aspects.apps.provides.sh.provides.zoxide = {
    description = "Zoxide";

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs = {
          zoxide = {
            enable = true;
            enableBashIntegration = true;
            enableZshIntegration = false;
          };
          zsh.plugins = [
            {
              name = "zoxide";
              src = pkgs.runCommand "zoxide-init-zsh" { } ''
                mkdir -p "$out/share/zoxide"
                ${lib.getExe config.programs.zoxide.package} init zsh > "$out/share/zoxide/init.zsh"
              '';
              file = "share/zoxide/init.zsh";
            }
          ];
        };
      };
  };
}
