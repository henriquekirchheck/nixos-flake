{ den, ... }:
{
  den.aspects.henrique = {
    includes = [
      den._.primary-user
      (den._.user-shell "zsh")

      den.aspects.apps._.sops
      
      # TODO: Fix when https://github.com/vic/den/issues/145 resolved
      # den.aspects.apps._.nix._.trusted-user
      
      # den.aspects.hardware._.printer._.permission
      # den.aspects.hardware._.scanner._.permission
      # den.aspects.hardware._.audio._.professional._.permission
      # den.aspects.hardware._.networking._.network-manager._.permission

      den.aspects.hardware._.android

      # TODO: Fix later because it seems to be defined twice on homeManager
      # den.aspects.window-managers._.niri

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
  };
}
