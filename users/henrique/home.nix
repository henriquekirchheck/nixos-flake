{ config, ... }:
{
  imports = [
    ../../modules/programs/shell/zsh/home.nix
    ../../modules/programs/shell/extras/direnv
    ../../modules/programs/shell/extras/fzf
    ../../modules/programs/shell/extras/starship
    ../../modules/programs/shell/extras/zoxide
    ../../modules/programs/jujutsu
    ../../modules/programs/git
    ../../modules/programs/git/gh.nix
    ../../modules/programs/discord/nixcord.nix
    ../../modules/programs/mpv
    ../../modules/programs/nh
    ../../modules/programs/gimp
    ../../modules/programs/ardour
    ../../modules/programs/ffmpeg
    ../../modules/programs/aegisub
    ../../modules/programs/libreoffice

    ../../modules/development/c
    ../../modules/development/python
    ../../modules/development/rust
    ../../modules/development/nix
    ../../modules/development/javascript
    ../../modules/development/tex

    ../../modules/hardware/bluetooth/home.nix

    ../../modules/compatibility/wine
    ../../modules/compatibility/bottles
    ../../modules/system/virtualisation/containers/distrobox.nix

    ../../modules/programs/browsers/firefox
    ../../modules/programs/terminal/kitty
    ../../modules/programs/editors/codium
    ../../modules/programs/editors/neovim
    ../../modules/programs/editors/emacs

    ../../modules/games/godot
    ../../modules/games/prismlauncher

    ../../modules/wm/niri/home.nix
    ../../modules/programs/notification/dunst.nix
    ../../modules/programs/rofi
    ../../modules/programs/waybar
    ../../modules/programs/wallpaper/swww.nix

    ../../modules/styles/fonts/home.nix
    ../../modules/styles/cursor
    ../../modules/styles/gtk
    ../../modules/styles/qt
  ];

  # Home Specific
  home.username = "henrique";
  home.homeDirectory = "/home/henrique";
  home.stateVersion = "25.05";

  ## Integration
  home.shell.enableShellIntegration = true;

  ## Prefer wayland
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    GTK_USE_PORTAL = "1";
  };

  ## Defaults
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "codium -w";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  ## nh
  home.sessionVariables = {
    NH_FLAKE = "${config.home.homeDirectory}/src/dotfiles";
  };

  ## SOPS
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
  };

  ## SSH
  sops.secrets.private = {
    sopsFile = ./secrets/sshkey.yaml;
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  };
  sops.secrets.public = {
    sopsFile = ./secrets/sshkey.yaml;
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "4h";
      };
      "git" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = [ config.sops.secrets.private.path ];
      };
    };
  };

  ## Git
  programs.git = {
    userName = "Henrique Kirch Heck";
    userEmail = "me@henriquekh.dev.br";
    signing = {
      signByDefault = true;
      key = config.sops.secrets.public.path;
    };
    extraConfig.gpg.format = "ssh";
  };

  ## Git
  programs.jujutsu.settings = {
    user.name = "Henrique Kirch Heck";
    user.email = "me@henriquekh.dev.br";
  };

  # XDG Dirs
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/media/music";
      videos = "${config.home.homeDirectory}/media/videos";
      pictures = "${config.home.homeDirectory}/media/pictures";
      templates = "${config.home.homeDirectory}/templates";
      download = "${config.home.homeDirectory}/downloads";
      documents = "${config.home.homeDirectory}/dcuments";
      desktop = null;
      publicShare = null;
      extraConfig = {
        XDG_DOTFILES_DIR = "${config.home.homeDirectory}/src/dotfiles";
      };
    };
    mime.enable = true;
    mimeApps.enable = true;
  };
}
