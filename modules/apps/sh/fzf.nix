{
  den.aspects.apps.provides.sh.provides.fzf = {
    description = "fuzzy finder";

    homeManager = { config, pkgs, ... }: {
      programs = {
        fzf = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = false;
        };
        zsh.plugins = [
          {
            name = "fzf-completion";
            src = config.programs.fzf.package;
            file = "share/fzf/completion.zsh";
          }
          {
            name = "fzf-key-bindings";
            src = config.programs.fzf.package;
            file = "share/fzf/key-bindings.zsh";
          }
          {
            name = "fzf-tab";
            src = pkgs.zsh-fzf-tab;
            file = "share/fzf-tab/fzf-tab.plugin.zsh";
            functions = [ "share/fzf-tab/lib" ];
          }
        ];
      };
    };
  };
}
