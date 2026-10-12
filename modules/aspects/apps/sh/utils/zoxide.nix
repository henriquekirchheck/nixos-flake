{ den, __findFile, ... }:
{
  den.aspects.apps.sh.utils.zoxide = {
    includes = [
      (den.lib.policy.when (
        { host, ... }: host.hasAspect <apps/sh/shells/zsh>
      ) <apps/sh/utils/zoxide/zsh>)
    ];

    homeManager.programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
      enableFishIntegration = true;
    };
  };

  den.aspects.apps.sh.utils.zoxide.zsh = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs.zsh.plugins = [
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

    cacheHome = _: {
      directories = [ ".local/share/zoxide" ];
    };
  };
}
