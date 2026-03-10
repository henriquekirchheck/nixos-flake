{ den, ... }:
{
  den.aspects.maria = {
    includes = [
      den.aspects.hardware._.printer._.permission
      den.aspects.hardware._.scanner._.permission
      den.aspects.hardware._.networking._.network-manager._.permission
      den.aspects.hardware._.audio._.professional._.permission

      den.aspects.hardware._.android

      den.aspects.apps._.window-managers._.plasma

      den.aspects.apps._.comma

      den.aspects.apps._.media._.images._.krita
      den.aspects.apps._.media._.images._.gimp
      den.aspects.apps._.media._.ffmpeg
      den.aspects.apps._.media._.mpv

      den.aspects.apps._.documents._.libreoffice

      den.aspects.apps._.wine

      den.aspects.apps._.web._.chromium

      den.aspects.apps._.terminals._.alacritty

      (den.aspects.utils._.user._.xdg-dirs { })
    ];

    nixos = {
      users.users.maria = {
        description = "Maria Cecilia Kirch";
        initialPassword = "password";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHzo1AzCHMwR6sctkN8hxilkKvjnr96xWPotO3eTcxR me@henriquekh.dev.br"
        ];
      };
    };

    homeManager =
      {
        home.sessionVariables = {
          BROWSER = "chromium";
        };
        xdg = {
          enable = true;
          mime.enable = true;
          mimeApps = {
            enable = true;
            defaultApplications = {
              "text/html" = "chromium-browser.desktop";
              "application/xhtml+xml" = "chromium-browser.desktop";
              "application/vnd.mozilla.xul+xml" = "chromium-browser.desktop";
              "x-scheme-handler/http" = "chromium-browser.desktop";
              "x-scheme-handler/https" = "chromium-browser.desktop";
              "x-scheme-handler/mailto" = "chromium-browser.desktop";
              "text/x-vcard" = "chromium-browser.desktop";
              "text/calendar" = "chromium-browser.desktop";
              "message/rfc822" = "chromium-browser.desktop";
              "inode/directory" = "dolphin.desktop";
            };
          };
        };
      };
  };
}
