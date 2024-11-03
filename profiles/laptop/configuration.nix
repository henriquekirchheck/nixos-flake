# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  terminal,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../base/configuration.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/amd-gpu.nix
    ../../system/hardware/backlight.nix
    ../../system/wm/kde.nix
  ];

  # Force use of pt_BR on laptop
  i18n.defaultLocale = lib.mkForce "pt_BR.UTF-8";

  # Mom's user
  users.users.maria = {
    isNormalUser = true;
    description = "Maria";
    extraGroups = [ "networkmanager" ];
    packages = [
      pkgs.firefox
      pkgs.ungoogled-chromium
      pkgs.${terminal}
    ];
    initialPassword = "12345";
  };
}
