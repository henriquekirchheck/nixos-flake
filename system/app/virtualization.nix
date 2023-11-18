{ config, lib, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [ virt-manager virtualbox ];
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
  users.users.${username}.extraGroups = [ "libvirt" "kvm" ];
}
