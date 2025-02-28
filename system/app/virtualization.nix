{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  environment.systemPackages = [
    pkgs.qemu
    pkgs.quickemu
  ];
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;
  users.users.${username}.extraGroups = [
    "libvirtd"
    "kvm"
  ];
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
  # boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];
  # environment.systemPackages = with pkgs; [ virtualbox ];
}
