{
  den.aspects.apps.sh.shells.zsh = {
    nixos.programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableGlobalCompInit = false;
    };
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;

          dotDir = "${config.xdg.configHome}/zsh";

          history = {
            ignoreDups = true;
            ignoreAllDups = true;
            ignoreSpace = true;
            expireDuplicatesFirst = true;
          };

          completionInit = ''
            autoload -Uz compinit
            if [[ ! -s "$XDG_CACHE_HOME/zcompdump" || /run/current-system/sw -nt "$XDG_CACHE_HOME/zcompdump" ]]; then
              compinit
              zcompile "$XDG_CACHE_HOME/zcompdump"
            else
              compinit -C
            fi
          '';

          initContent = lib.mkMerge [
            (lib.mkBefore "[[ $ZSH_PROFILE_RC -gt 0 ]] && zmodload zsh/zprof")
            (lib.mkAfter "[[ $ZSH_PROFILE_RC -gt 0 ]] && zprof")

            # No sorting git checkout
            "zstyle ':completion:*:git-checkout:*' sort false"
            # set list-colors to enable filename colorizing
            "zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}"
            "zstyle ':completion:*' completer _expand _complete _ignored _approximate"
            "zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'"
            # sudo completions
            "zstyle ':completion::complete:*' gain-privileges 1"
            "zstyle ':completion::complete:*' use-cache 1"
            # give a preview of commandline arguments when completing `kill`
            ''zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"''
            # set descriptions format to enable group support
            "zstyle ':completion:*:descriptions' format %d"
          ];

          historySubstringSearch = {
            enable = true;
            searchUpKey = [
              "^[[A"
              "$terminfo[kcuu1]"
            ];
            searchDownKey = [
              "^[[B"
              "$terminfo[kcud1]"
            ];
          };

          plugins = lib.mkAfter [
            {
              name = "fast-syntax-highlighting";
              src = pkgs.zsh-fast-syntax-highlighting;
              file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
            }
            {
              name = "zsh-completion-sync";
              src = pkgs.zsh-completion-sync;
              file = "share/zsh-completion-sync/zsh-completion-sync.plugin.zsh";
            }
          ];
        };
      };

    cacheHome = _: {
      files = [ ".config/zsh/.zsh_history" ];
    };
  };
}
