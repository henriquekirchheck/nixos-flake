# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, wm, mainLocale, extraLocale, timeZone, username, name, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../system/hardware-configuration.nix
      ../../system/hardware/bootloader.nix
      ../../system/hardware/console.nix
      ../../system/hardware/kernel.nix
      ../../system/hardware/networking.nix
      ../../system/hardware/nvidia.nix
      ../../system/hardware/printing.nix
      (./. + "../../../system/wm" + ("/" + wm) + ".nix")
      ../../system/app/flatpak.nix
      ../../system/app/virtualization.nix
      ( import ../../system/app/docker.nix {storageDriver = "btrfs"; inherit username pkgs config lib;} )
      ../../system/app/zsh.nix
      ../../system/app/steam.nix
      ../../system/security/privilege_escalation/doas.nix
      ../../system/security/firewall.nix
      ../../system/security/gpg.nix
      ../../system/security/sshd.nix
    ];

  networking.hostName = "${username}-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  time.timeZone = timeZone;

  i18n = {
    defaultLocale = mainLocale;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
    uid = 1000;
    initialPassword = "12345";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    eza
    fd
    ripgrep
    zsh
    btop
    htop
    vim
    bash
    home-manager
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05";
}
