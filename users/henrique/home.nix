{ config, ... }:
{
  imports = [
    ../../modules/programs/shell/zsh
    ../../modules/programs/shell/extras/direnv
    ../../modules/programs/shell/extras/fzf
    ../../modules/programs/shell/extras/starship
    ../../modules/programs/shell/extras/zoxide
    ../../modules/programs/git
    ../../modules/programs/git/gh.nix
    ../../modules/programs/discord/vesktop.nix
    ../../modules/programs/mpv

    ../../modules/development/c
    ../../modules/development/python
    ../../modules/development/rust
    ../../modules/development/nix
    ../../modules/development/javascript
    ../../modules/development/tex

    ../../modules/compatibility/wine
    ../../modules/compatibility/bottles
    ../../modules/system/virtualisation/containers/distrobox.nix

    ../../modules/programs/browsers/firefox
    ../../modules/programs/terminal/kitty
    ../../modules/programs/editors/codium
    ../../modules/programs/editors/neovim

    ../../modules/games/godot
    ../../modules/games/prismlauncher

    ../../modules/wm/hyprland/home.nix
    ../../modules/programs/notification/dunst.nix

    ../../modules/styles/cursor
    ../../modules/styles/gtk
    ../../modules/styles/qt
  ];

  # Home Specific
  home.username = "henrique";
  home.homeDirectory = "/home/henrique";
  home.stateVersion = "25.05";

  ## Prefer wayland
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  ## Defaults
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "codium";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  ## Git
  programs.git = {
    userName = "Henrique Kirch Heck";
    userEmail = "86362827+henriquekirchheck@users.noreply.github.com";
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
