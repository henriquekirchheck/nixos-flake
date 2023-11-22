{ config, lib, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [ virtualbox ];
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
  users.users.${username}.extraGroups = [ "libvirtd" "kvm" ];
}
