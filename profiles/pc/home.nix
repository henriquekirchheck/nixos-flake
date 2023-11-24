{ config, pkgs, lib, username, editor, terminal, browser, dotfilesDir, wm, mainEditor, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/"+username;

  programs.home-manager.enable = true;

  imports = [
    ../../user/wm/${wm}.nix
    ../../user/app/browser/${browser}.nix
    ../../user/app/terminal/${terminal}.nix
    ../../user/app/editor/${mainEditor}.nix
    ../../user/shell/sh.nix
    ../../user/shell/cmd-utils.nix
    ../../user/app/development/git.nix
    ../../user/app/development/cc.nix
    ../../user/app/development/python.nix
    ../../user/app/development/rust.nix
    ../../user/app/development/nix.nix
    ../../user/app/development/js.nix
    ../../user/app/sandboxing/flatpak.nix
    ../../user/app/sandboxing/virtualization.nix
    ../../user/app/sandboxing/wine.nix
    ../../user/app/games/yuzu.nix
    ../../user/app/games/ryujinx.nix
    ../../user/app/games/prismlauncher.nix
    ../../user/app/chat/discord.nix
    ../../user/app/media/mpv.nix
    ../../user/styles/gtk.nix
    ../../user/styles/qt.nix
    ../../user/hardware/sound.nix
  ];

  home.packages = with pkgs; [
    hello
    nix-index
    libreoffice-fresh
  ];

  home.stateVersion = "23.05";

  home.sessionVariables = {
    EDITOR = editor;
    TERMINAL = terminal;
    BROWSER = browser;
  };

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
        XDG_DOTFILES_DIR = "${config.home.homeDirectory}/${dotfilesDir}";
      };
    };
    mime.enable = true;
    mimeApps.enable = true;
  };
}
