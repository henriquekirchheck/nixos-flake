{ config, ... }:
{
  imports = [
    ../../modules/programs/shell/zsh/home.nix
    ../../modules/programs/shell/extras/direnv
    ../../modules/programs/shell/extras/fzf
    ../../modules/programs/shell/extras/starship
    ../../modules/programs/shell/extras/zoxide

    ../../modules/programs/development/vcs/jujutsu
    ../../modules/programs/development/vcs/git
    ../../modules/programs/development/vcs/git/gh.nix
    ../../modules/programs/development/vcs/git/fj.nix

    ../../modules/programs/development/language/c
    ../../modules/programs/development/language/python
    ../../modules/programs/development/language/rust
    ../../modules/programs/development/language/nix
    ../../modules/programs/development/language/javascript
    ../../modules/programs/development/language/tex
    ../../modules/programs/development/language/godot

    ../../modules/programs/development/editor/codium
    ../../modules/programs/development/editor/neovim
    ../../modules/programs/development/editor/emacs
    ../../modules/programs/development/editor/zed

    ../../modules/programs/communication/discord/nixcord.nix
    ../../modules/programs/communication/thunderbird

    ../../modules/programs/utility/nh
    ../../modules/programs/utility/comma

    ../../modules/programs/media/common/ffmpeg
    ../../modules/programs/media/common/mpv

    ../../modules/programs/media/image/gimp
    ../../modules/programs/media/image/oculante
    ../../modules/programs/media/image/swayimg

    ../../modules/programs/media/audio/reaper
    ../../modules/programs/media/audio/mpd
    ../../modules/programs/media/audio/mpris-scrobbler
    ../../modules/programs/media/audio/tidal-hifi

    ../../modules/programs/media/subtitle/aegisub

    ../../modules/programs/media/model/blender

    ../../modules/programs/document/libreoffice
    ../../modules/programs/document/zathura

    ../../modules/programs/web/aria2
    ../../modules/programs/web/firefox

    ../../modules/programs/game/prismlauncher

    ../../modules/programs/compatibility/wine
    ../../modules/programs/compatibility/bottles

    ../../modules/programs/terminal/alacritty

    ../../modules/hardware/bluetooth/home.nix

    ../../modules/system/virtualisation/containers/distrobox.nix

    ../../modules/wm/niri/home.nix
    ../../modules/programs/bar/quickshell/dms
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
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    GTK_USE_PORTAL = "1";
  };

  ## Defaults
  home.sessionVariables = {
    EDITOR = "emacsclient -nw -c";
    VISUAL = "emacsclient -c";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
  };

  ## nh
  programs.nh.flake = "${config.home.homeDirectory}/src/dotfiles";

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
    settings = {
      user.name = "Henrique Kirch Heck";
      user.email = "me@henriquekh.dev.br";
      gpg.format = "ssh";
    };
    signing = {
      signByDefault = true;
      key = config.sops.secrets.public.path;
    };
  };

  sops.secrets.codeberg-token = {
    sopsFile = ./secrets/forgejo.yaml;
  };
  programs.forgejo-cli.hosts."codeberg.org".tokenFile = config.sops.secrets.codeberg-token.path;

  ## Jujutsu
  programs.jujutsu.settings = {
    user.name = "Henrique Kirch Heck";
    user.email = "me@henriquekh.dev.br";
  };

  ## Accounts
  sops.secrets.personal = {
    sopsFile = ./secrets/accounts.yaml;
  };
  sops.secrets.games = {
    sopsFile = ./secrets/accounts.yaml;
  };
  accounts.email.accounts =
    let
      shared = {
        flavor = "gmail.com";
        thunderbird.enable = true;
        smtp.tls.useStartTls = true;
      };
    in
    {
      personal = {
        primary = true;
        realName = "Henrique Kirch Heck";
        address = "henriquekirchheck@gmail.com";
        passwordCommand = "cat ${config.sops.secrets.personal.path}";
      }
      // shared;
      games = {
        realName = "GamesRevolution";
        address = "henrique.gamesrev@gmail.com";
        passwordCommand = "cat ${config.sops.secrets.games.path}";
      }
      // shared;
    };
  programs.thunderbird.profiles.user.accountsOrder = [
    "personal"
    "games"
  ];

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
