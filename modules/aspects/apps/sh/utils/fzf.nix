{ den, __findFile, ... }:
{
  den.aspects.apps.sh.utils.fzf = {
    includes = [
      (den.lib.policy.when ({ host, ... }: host.hasAspect <apps/sh/shells/zsh>) <apps/sh/utils/fzf/zsh>)
      (den.lib.policy.when ({ host, ... }: host.hasAspect <apps/sh/shells/fish>) <apps/sh/utils/fzf/fish>)
    ];

    homeManager = {
      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = false;
        enableFishIntegration = true;
      };
    };
  };

  den.aspects.apps.sh.utils.fzf.zsh = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs.zsh = {
          plugins = [
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
          initContent = lib.mkMerge [
            # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
            "zstyle ':completion:*' menu no"
            "zstyle ':completion:*' queeze-slashes true"
            # preview directory's content with eza when completing cd
            "zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'"
            "zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'"
            # preview processes
            "zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == \"[process ID]\" ]] && ps --pid=$word -o cmd --no-headers -w -w'"
            "zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap"
            # preview systemd units
            "zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'"
            # preview variables
            "zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ''\${(P)word}'"
            # switch group using `<` and `>`
            "zstyle ':fzf-tab:*' switch-group '<' '>'"
            "zstyle ':fzf-tab:complete:-command-:*' fzf-preview '(out=$(tldr --color always \"$word\") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man \"$word\") 2>/dev/null && echo $out) || (out=$(which \"$word\") && echo $out) || echo \"''\${(P)word}\"'"
            # preview git
            "zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'"
            "zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'"
            "zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'"
            ''
              zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
              	'case "$group" in
              	"commit tag") git show --color=always $word ;;
              	*) git show --color=always $word | delta ;;
              	esac'
            ''
            ''
              zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
              	'case "$group" in
              	"modified file") git diff $word | delta ;;
              	"recent commit object name") git show --color=always $word | delta ;;
              	*) git log --color=always $word ;;
              	esac'
            ''
            # Random previews
            "zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'"
            ''
              zstyle ':fzf-tab:complete:lsof:option-i-1' fzf-preview \
                'case $group in
                port) lsof -i :$word;;
                *) lsof -i $word;;
                esac'
            ''
            # Preview C/C++ compilers
            "zstyle ':fzf-tab:complete:clang:argument-rest' fzf-preview 'clang -o- -S $realpath | bat -lasm'"
            "zstyle ':fzf-tab:complete:clang++:argument-rest' fzf-preview 'clang++ -o- -S $realpath | bat -lasm'"
            "zstyle ':fzf-tab:complete:cc:argument-rest' fzf-preview 'cc -o- -S $realpath | bat -lasm'"
            "zstyle ':fzf-tab:complete:c++:argument-rest' fzf-preview 'c++ -o- -S $realpath | bat -lasm'"
            "zstyle ':fzf-tab:complete:g++:argument-rest' fzf-preview 'g++ -o- -S $realpath | bat -lasm'"
            ''
              zstyle ':fzf-tab:complete:gcc:*' fzf-preview \
                'case $group in
                "input file") gcc -o- -S $realpath | bat -lasm;;
                help) gcc --help=$word | bat -lhelp;;
                esac'
            ''
          ];
        };
      };
  };

  den.aspects.apps.sh.utils.fzf.fish = {
    homeManager = { pkgs, ... }: {
      programs.fish = {
        plugins = [
          {
            name = "fifc";
            src = pkgs.fishPlugins.fifc.src;
          }
        ];
      };
    };
  };
}
