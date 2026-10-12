{
  den.aspects.apps.virtualisation.libvirtd = {
    nixos = { pkgs, ... }: {
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu;
          swtpm.enable = true;
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
        nss.enableGuest = true;
      };
      environment.systemPackages = [ pkgs.dnsmasq ];
    };

    persist = _: { directories = [ "/var/lib/libvirt" ]; };
  };

  den.aspects.apps.virtualisation.libvirtd.permission = {
    user.extraGroups = [ "libvirtd" ];
  };
}
