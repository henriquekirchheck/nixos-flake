{ den, __findFile, ... }:
{
  den.aspects.apps.sh.utils.direnv = {
    includes = [
      (den.lib.policy.when (
        { host, ... }: host.hasAspect <apps/sh/shells/zsh>
      ) <apps/sh/utils/direnv/zsh>)
    ];

    homeManager.programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
      enableFishIntegration = true;
      enableGitIntegration = true;

      nix-direnv.enable = true;
    };

    cacheHome = _: { directories = [ ".local/state/direnv" ]; };
  };

  den.aspects.apps.sh.utils.direnv.zsh = {
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
}
