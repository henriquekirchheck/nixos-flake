{ config, pkgs, ... }:
let
  myAliases = {
    # ls
    ls = "eza -al --color=always --group-directories-first --icons=always"; # List of Hidden files and directories
    la = "eza -a --color=always --group-directories-first --icons=always";  # All files and directories
    ll = "eza -l --color=always --group-directories-first --icons=always";  # List of files and directories
    lt = "eza -aT --color=always --group-directories-first --icons=always"; # Tree of all files and directories

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
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = myAliases;
    dotDir = ".config/zsh";
    autodir = true;
    historySubstringSearch = true;
    history = {
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };
    # syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "fast-syntax-highlighting";
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
    neofetch lolcat cowsay onefetch
    gnugrep gnused
    bat eza bottom fd
    direnv nix-direnv
    starship zoxide
    zsh-fast-syntax-highlighting
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    config = {
      format = """ $directory($git_branch )($git_state )($rust )($deno )($nodejs )($python )$character""";
      right_format = """$cmd_duration""";
      add_newline = false;
      line_break.disabled = true;
      character = {
        format = "$symbol ";
        success_symbol = "[❯](#0ce8;30)";
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
      git_branch = {
        format = "[$symbol( $branch(:$remote_branch))]($style)";
        symbol = "";
      };
      git_state = {
        format = "[$progress_current/$progress_total]($style)";
      };
      deno = {
        format = "[$symbol ($version)]($style)";
        symbol = "";
      };
      nodejs = {
        format = "[$symbol ($version)]($style)";
        symbol = "";
      };
      python = {
        symbol = "";
        format = ''[$symbol ($version)( ''${pyenv_prefix})( $virtualenv)]($style)'';
      };
      rust = {
        symbol = "";
        format = "[$symbol ($version)]($style)";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}