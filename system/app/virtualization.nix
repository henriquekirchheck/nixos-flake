{ config, lib, pkgs, username, ... }:

{
  virtualisation.libvirtd = {
    allowedBridges = [ "nm-bridge" "virbr0" ];
    enable = true;
    qemu.runAsRoot = false;
  };
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" "kvm" ];
  # boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
  # environment.systemPackages = with pkgs; [ virtualbox ];
}
