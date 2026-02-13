{ den, ... }:
{
  den.aspects.henrique = {
    includes = [
      den._.primary-user
      (den._.user-shell "zsh")

      den.aspects.apps._.sh._.bash
      den.aspects.apps._.sh._.zsh
      den.aspects.apps._.sh._.aliases
      den.aspects.apps._.sh._.direnv
      den.aspects.apps._.sh._.fzf
      den.aspects.apps._.sh._.starship
      den.aspects.apps._.sh._.zoxide

      den.aspects.apps._.sops

      den.aspects.apps._.nix._.trusted-user

      den.aspects.hardware._.printer._.permission
      den.aspects.hardware._.scanner._.permission
      den.aspects.hardware._.audio._.professional._.permission
      den.aspects.hardware._.networking._.network-manager._.permission
      den.aspects.apps._.virtualisation._.permission
      den.aspects.hardware._.android._.permission
      den.aspects.apps._.containers._.docker._.permission
      den.aspects.hardware._.audio._.professional._.permission

      den.aspects.hardware._.android
      den.aspects.hardware._.tablet

      den.aspects.apps._.window-managers._.niri
      den.aspects.apps._.wallpapers._.swww
      den.aspects.apps._.shell._.dms
      den.aspects.apps._.shell._.dms._.niri

      den.aspects.apps._.fonts
      den.aspects.apps._.nh
      den.aspects.apps._.cli
      den.aspects.apps._.security._.permission._.doas
      den.aspects.apps._.security._.permission._.doas._.sudo-alias
      den.aspects.apps._.containers._.distrobox

      den.aspects.apps._.games._.minecraft._.launchers._.prismlauncher
      den.aspects.apps._.games._.steam
      den.aspects.apps._.games._.gamemode
      den.aspects.apps._.games._.gamescope
      den.aspects.apps._.comma
      den.aspects.apps._.nh

      den.aspects.apps._.media._.videos._.obs
      den.aspects.apps._.media._.videos._.yt-dlp
      den.aspects.apps._.media._.subtitles._.aegisub
      den.aspects.apps._.media._.models._.blender
      den.aspects.apps._.media._.images._.swayimg
      den.aspects.apps._.media._.images._.krita
      den.aspects.apps._.media._.images._.gimp
      den.aspects.apps._.media._.audio._.tidal-hifi
      den.aspects.apps._.media._.audio._.mpd
      den.aspects.apps._.media._.ffmpeg
      den.aspects.apps._.media._.mpv

      den.aspects.apps._.communication._.nixcord

      den.aspects.apps._.documents._.zathura
      den.aspects.apps._.documents._.libreoffice

      den.aspects.apps._.development._.languages._.cxx
      den.aspects.apps._.development._.languages._.python
      den.aspects.apps._.development._.languages._.rust
      den.aspects.apps._.development._.languages._.nix
      den.aspects.apps._.development._.languages._.javascript
      den.aspects.apps._.development._.languages._.tex
      den.aspects.apps._.development._.languages._.typst

      den.aspects.apps._.development._.game-engines._.godot

      den.aspects.apps._.development._.editors._.codium
      den.aspects.apps._.development._.editors._.neovim
      den.aspects.apps._.development._.editors._.zed

      den.aspects.apps._.development._.versioning._.git
      (den.aspects.apps._.development._.versioning._.git._.include-settings {
        user.name = "Henrique Kirch Heck";
        user.email = "me@henriquekh.dev.br";
        gpg.format = "ssh";
      })
      (den.aspects.apps._.development._.versioning._.git._.include-ssh-signing {
        sopsFile = ./secrets/sshkey.yaml;
        secretKey = "public";
      })

      den.aspects.apps._.development._.versioning._.git._.delta

      den.aspects.apps._.development._.versioning._.git._.gh
      (den.aspects.services._.ssh._.client._.add-host {
        sopsFile = ./secrets/sshkey.yaml;
        secretKey = "private";
        domain = "github.com";
      })

      den.aspects.apps._.development._.versioning._.git._.forgejo-cli
      (den.aspects.apps._.development._.versioning._.git._.forgejo-cli._.add-host {
        hostname = "codeberg.org";
        username = "henriquekh";
        sopsFile = ./secrets/forgejo.yaml;
        secretKey = "codeberg-token";
        alias = "fjc";
      })
      (den.aspects.services._.ssh._.client._.add-host {
        sopsFile = ./secrets/sshkey.yaml;
        secretKey = "private";
        domain = "codeberg.org";
      })

      den.aspects.apps._.development._.versioning._.jujutsu
      (den.aspects.apps._.development._.versioning._.jujutsu._.include-settings {
        user.name = "Henrique Kirch Heck";
        user.email = "me@henriquekh.dev.br";
      })

      den.aspects.apps._.communication._.email._.thunderbird
      (den.aspects.apps._.communication._.email._.add-email rec {
        name = "personal";
        realName = "Henrique Kirch Heck";
        address = "henriquekirchheck@gmail.com";
        flavor = "gmail.com";
        sopsFile = ./secrets/accounts.yaml;
        secretKey = name;
        primary = true;
      })
      (den.aspects.apps._.communication._.email._.thunderbird._.add-account "personal")
      (den.aspects.apps._.communication._.email._.add-email rec {
        name = "games";
        realName = "GamesRevolution";
        address = "henrique.gamesrev@gmail.com";
        flavor = "gmail.com";
        sopsFile = ./secrets/accounts.yaml;
        secretKey = name;
      })
      (den.aspects.apps._.communication._.email._.thunderbird._.add-account "games")

      den.aspects.apps._.wine
      den.aspects.apps._.wine._.bottles

      den.aspects.apps._.web._.aria2
      den.aspects.apps._.web._.firefox

      den.aspects.apps._.terminals._.alacritty

      den.aspects.services._.zerotier

      (den.aspects.utils._.user._.password {
        key = "password";
        sopsFile = ./secrets/password.yaml;
      })

      den.aspects.services._.ssh._.server._.allow-user
      den.aspects.services._.ssh._.client
      (den.aspects.services._.ssh._.client._.secret-keys {
        keyPath = ".ssh/id_ed25519";
        sopsFile = ./secrets/sshkey.yaml;
      })

      (den.aspects.utils._.user._.xdg-dirs {
        music = "media/music";
        videos = "media/videos";
        pictures = "media/pictures";
        templates = "templates";
        download = "downloads";
        documents = "dcuments";
        dotfiles = "src/dotfiles";
      })
    ];

    nixos = {
      users.users.henrique = {
        description = "Henrique Kirch Heck";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHzo1AzCHMwR6sctkN8hxilkKvjnr96xWPotO3eTcxR me@henriquekh.dev.br"
        ];
      };
    };

    homeManager =
      { config, ... }:
      {
        programs.nh.flake = "${config.home.homeDirectory}/src/dotfiles";
        stylix.targets.firefox.profileNames = [ "user" ];
        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "zeditor";
          TERMINAL = "alacritty";
          BROWSER = "firefox";
        };
        stylix.targets.qt.platform = "qtct";
        xdg = {
          enable = true;
          mime.enable = true;
          mimeApps = {
            enable = true;
            associations.added = {
              "inode/directory" = [
                "Alacritty.desktop"
                "dev.zed.Zed.desktop"
              ];
            };
            defaultApplications = {
              "text/html" = "firefox.desktop";
              "application/xhtml+xml" = "firefox.desktop";
              "application/vnd.mozilla.xul+xml" = "firefox.desktop";
              "x-scheme-handler/http" = "firefox.desktop";
              "x-scheme-handler/https" = "firefox.desktop";
              "text/plain" = "dev.zed.Zed.desktop";
              "inode/directory" = "Alacritty.desktop";
            };
          };
        };
      };
  };
}
