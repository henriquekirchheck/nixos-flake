{ config, pkgs, username, editor, terminal, browser, dotfilesDir, wm, mainEditor, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/"+username;

  programs.home-manager.enable = true;

  imports = [
    ../../user/wm/${wm}.nix
    ../../app/browser/${browser}.nix
    ../../app/terminal/${terminal}.nix
    ../../app/editor/${mainEditor}.nix
    ../../user/shell/sh.nix
    ../../user/shell/cmd-utils.nix
    ../../user/development/git.nix
    ../../user/development/cc.nix
    ../../user/development/python.nix
    ../../user/development/rust.nix
    ../../user/sandboxing/flatpak.nix
    ../../user/sandboxing/virtualization.nix
    ../../user/sandboxing/wine.nix
    ../../user/games/yuzu.nix
    ../../user/games/ryjinx.nix
  ];

  home.packages = with pkgs; [
    hello
  ];

  home.stateVersion = "23.05";

  home.sessionVariables = {
    EDITOR = editor;
    TERM = terminal;
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