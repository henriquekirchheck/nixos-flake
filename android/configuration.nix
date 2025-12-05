{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/system/nix

    ../modules/programs/shell/zsh
    ../modules/programs/utilities/cli.nix

    ../modules/cache/nixos.nix
  ];

  system.stateVersion = "26.05";

  time.timeZone = "America/Sao_Paulo";
  i18n =
    let
      extraLocale = "pt_BR.UTF-8";
      defaultLocale = "en_US.UTF-8";
    in
    {
      inherit defaultLocale;
      extraLocaleSettings = {
        LC_ADDRESS = extraLocale;
        LC_IDENTIFICATION = extraLocale;
        LC_MEASUREMENT = extraLocale;
        LC_MONETARY = extraLocale;
        LC_NAME = extraLocale;
        LC_NUMERIC = extraLocale;
        LC_PAPER = extraLocale;
        LC_TELEPHONE = extraLocale;
        LC_TIME = extraLocale;
      };
    };
}
