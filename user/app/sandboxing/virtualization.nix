{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    libvirt
    virt-manager
    qemu
    uefi-run
    lxc
    swtpm
  ];

  home.file.".config/libvirt/qemu.conf".text = ''nvram = ["/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]'';
}