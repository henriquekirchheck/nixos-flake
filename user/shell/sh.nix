{ config, pkgs, lib, ... }:
let
  myAliases = {
    # ls
    ls =
      "eza -al --color=always --group-directories-first --icons=always"; # List of Hidden files and directories
    la =
      "eza -a --color=always --group-directories-first --icons=always"; # All files and directories
    ll =
      "eza -l --color=always --group-directories-first --icons=always"; # List of files and directories
    lt =
      "eza -aT --color=always --group-directories-first --icons=always"; # Tree of all files and directories

    # grep
    grep = "grep --color=auto";

    # confirm before overwriting something
    cp = "cp -i";
    mv = "mv -i";

    # git
    gitfetch = "onefetch";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set descriptions format to enable group support
      # NOTE: don't use escape sequences here, fzf-tab will ignore them
      zstyle ':completion:*:descriptions' format %d
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      zstyle ':completion:*' menu no
      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
      # give a preview of commandline arguments when completing `kill`
      zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
        '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
      zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
      zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
            fzf-preview 'echo ''${(P)word}'
      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'
      zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
        '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "''${(P)word}"'
      # it is an example. you can change it
      zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
      	'git diff $word | delta'
      zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
      	'git log --color=always $word'
      zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
      	'git help $word | bat -plman --color=always'
      zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
      	'case "$group" in
      	"commit tag") git show --color=always $word ;;
      	*) git show --color=always $word | delta ;;
      	esac'
      zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
      	'case "$group" in
      	"modified file") git diff $word | delta ;;
      	"recent commit object name") git show --color=always $word | delta ;;
      	*) git log --color=always $word ;;
      	esac'
      zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
      zstyle ':fzf-tab:complete:cowsay:*' fzf-preview \
        'case $group in
          "cow file") cowsay -f $word "Hello World!";;
         esac'
      zstyle ':fzf-tab:complete:clang:argument-rest' fzf-preview 'clang -o- -S $realpath | bat -lasm'
      zstyle ':fzf-tab:complete:clang++:argument-rest' fzf-preview 'clang++ -o- -S $realpath | bat -lasm'
      zstyle ':fzf-tab:complete:cc:argument-rest' fzf-preview 'cc -o- -S $realpath | bat -lasm'
      zstyle ':fzf-tab:complete:c++:argument-rest' fzf-preview 'c++ -o- -S $realpath | bat -lasm'
      zstyle ':fzf-tab:complete:g++:argument-rest' fzf-preview 'g++ -o- -S $realpath | bat -lasm'
      zstyle ':fzf-tab:complete:gcc:*' fzf-preview \
        'case $group in
        "input file") gcc -o- -S $realpath | bat -lasm;;
        help) gcc --help=$word | bat -lhelp;;
        esac'
      zstyle ':fzf-tab:complete:(docker|docker-help):argument-1' fzf-preview 'docker help $word | bat -lhelp'
      zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview 'docker images $word'
      zstyle ':fzf-tab:complete:docker-inspect:*' fzf-preview ':fzf-tab:complete:docker-inspect:'
      zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview 'docker image $word --help'
      zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview 'docker container $word --help'
      zstyle ':fzf-tab:complete:lsof:option-i-1' fzf-preview \
        'case $group in
        port) lsof -i :$word;;
        *) lsof -i $word;;
        esac'
      zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview 'nix help $word | bat -lhelp'
    '';
    shellAliases = myAliases;
    dotDir = ".config/zsh";
    autocd = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" "$terminfo[kcuu1]" ];
      searchDownKey = [ "^[[B" "$terminfo[kcud1]" ];
    };
    history = {
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };
    # syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "share/fzf-tab/fzf-tab";
        src = pkgs.zsh-fzf-tab;
      }
      {
        name = "share/zsh/site-functions/fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
    ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
    fastfetch
    lolcat
    cowsay
    onefetch
    gnugrep
    gnused
    bat
    eza
    bottom
    fd
    delta
    tldr
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      format = lib.concatStrings [ "󱄅 " "$directory" "$all" "$character" ];
      right_format = lib.concatStrings [ "$cmd_duration" ];
      add_newline = false;
      line_break.disabled = true;
      character = {
        format = "$symbol ";
        success_symbol = "[❯](#0ce830)";
        error_symbol = "[❯](bright-red)";
        vicmd_symbol = "[❮](#0ce830)";
      };
      cmd_duration = {
        min_time = 5000;
        format = "[󰔟 $duration]($style)";
      };
      directory = {
        style = "#00ccff";
        read_only = " 󰌾";
        read_only_style = "bright-red";
        truncation_symbol = ".../";
        home_symbol = "~";
        truncation_length = 3;
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.lesspipe.enable = true;
}
