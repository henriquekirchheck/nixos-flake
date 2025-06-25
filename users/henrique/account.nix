{ config, pkgs, ... }:
{
  isNormalUser = true;
  description = "Henrique Kirch Heck";
  extraGroups = [
    "networkmanager"
    "wheel"
    "docker"
    "podman"
    "libvirtd"
    "kvm"
    "adbusers"
  ];
  hashedPasswordFile = config.sops.secrets."password/henrique".path;
  shell = pkgs.zsh;
  openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9uweW1W6G+NXidKR6FRq0BJVcSxkto04D8woERojKM u0_a336@phone"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHzo1AzCHMwR6sctkN8hxilkKvjnr96xWPotO3eTcxR me@henriquekh.dev.br"
  ];
}
