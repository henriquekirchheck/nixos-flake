{
  config,
  lib,
  pkgs,
  ...
}:

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
    ../../modules/programs/mpv
    ../../modules/programs/nh
    ../../modules/programs/ffmpeg
    ../../modules/programs/comma

    ../../modules/programs/editors/neovim
    ../../modules/programs/editors/emacs
  ];

  home.stateVersion = "24.05";

  home.shell.enableShellIntegration = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionVariables = {
    NH_FLAKE = "${config.home.homeDirectory}/src/dotfiles";
  };

  ## SSH
  # sops.secrets.private = {
  #   sopsFile = ./secrets/sshkey.yaml;
  #   path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  # };
  # sops.secrets.public = {
  #   sopsFile = ./secrets/sshkey.yaml;
  #   path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  # };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "4h";
      };
      # "git" = {
      #   host = "github.com";
      #   identitiesOnly = true;
      #   identityFile = [ config.sops.secrets.private.path ];
      # };
    };
  };

  programs.git = {
    settings = {
      user.name = "Henrique Kirch Heck";
      user.email = "me@henriquekh.dev.br";
      gpg.format = "ssh";
    };
    # signing = {
    #   signByDefault = true;
    #   key = config.sops.secrets.public.path;
    # };
  };

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
