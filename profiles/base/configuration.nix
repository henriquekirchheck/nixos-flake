{ config, pkgs, lib, wm, mainLocale, extraLocale, timeZone, username, name
, hostName, ... }:

{
  imports = [
    ../../system/hardware/bootloader.nix
    ../../system/hardware/console.nix
    ../../system/hardware/kernel.nix
    ../../system/hardware/networking.nix
    ../../system/hardware/printing.nix
    ../../system/hardware/sound.nix
    ../../system/wm/${wm}.nix
    ../../system/app/flatpak.nix
    (import ../../system/app/docker.nix {
      storageDriver = "btrfs";
      inherit username pkgs config lib;
    })
    ../../system/app/zsh.nix
    ../../system/app/steam.nix
    ../../system/app/obs.nix
    #../../system/app/dolphin.nix
    ../../system/app/nh.nix
    ../../system/security/privilege_escalation/doas.nix
    ../../system/security/firewall.nix
    ../../system/security/gpg.nix
    ../../system/extras/nix-ld.nix
  ];

  networking.hostName = hostName; # Define your hostname.

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
    packages = [ ];
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
    mpv
    ffmpeg-full
    file
    rustdesk-flutter
    zip
    unzip
    rar
    unrar
    dos2unix
    gimp
    krita
    rename
    imv
    zathura
    appimage-run
    pandoc
    jq
    ncdu
    libqalculate
    qalculate-gtk
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    optimise.automatic = true;
    package = pkgs.nixFlakes;
  };

  system.stateVersion = "23.05";
}
