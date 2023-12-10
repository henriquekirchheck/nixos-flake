{ config, pkgs, lib, wm, mainLocale, extraLocale, timeZone, username, name, profile, ... }:

{
  imports =
    [
      ../../system/hardware/bootloader.nix
      ../../system/hardware/console.nix
      ../../system/hardware/kernel.nix
      ../../system/hardware/networking.nix
      ../../system/hardware/printing.nix
      ../../system/wm/${wm}.nix
      ../../system/app/flatpak.nix
      ( import ../../system/app/docker.nix {storageDriver = "btrfs"; inherit username pkgs config lib;} )
      ../../system/app/zsh.nix
      ../../system/app/steam.nix
      ../../system/security/privilege_escalation/doas.nix
      ../../system/security/firewall.nix
      ../../system/security/gpg.nix
    ];

  networking.hostName = "${username}-${profile}"; # Define your hostname.

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
    mpv
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  system.stateVersion = "23.05";
}