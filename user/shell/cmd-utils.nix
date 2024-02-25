{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neofetch onefetch lolcat cowsay
    cava
    gnugrep gnused
    killall
    libnotify
    bat eza fd bottom ripgrep fzf
    rsync
    htop
    hwinfo
    unzip
    brightnessctl
    pandoc
    pciutils
  ];
}
