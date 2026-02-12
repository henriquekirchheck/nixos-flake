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
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
        home.sessionVariables = {
          BROWSER = "chromium";
        };
      };
  };
}
