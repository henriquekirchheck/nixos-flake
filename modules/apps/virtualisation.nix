{ den, ... }:
{
  den.aspects.apps.provides.virtualisation = {
    description = "Virtualisation";

    nixos =
      { pkgs, ... }:
      {
        virtualisation.libvirtd = {
          enable = true;
          qemu.swtpm.enable = true;
        };
        environment.systemPackages = [
          pkgs.dnsmasq
        ];
        networking.firewall.trustedInterfaces = [ "virbr0" ];
      };

    provides = {
      qemu = {
        includes = [ den.aspects.apps._.virtualisation ];
        nixos =
          { pkgs, ... }:
          {
            environment.defaultPackages = [
              pkgs.qemu
              pkgs.quickemu
            ];
            systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
          };
      };
      virt-manager = {
        includes = [ den.aspects.apps._.virtualisation ];
        nixos =
          { pkgs, ... }:
          {
            virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
            programs.virt-manager.enable = true;
          };
      };

      permission =
        { user, ... }:
        {
          nixos.users.users.${user.userName}.extraGroups = [ "libvirtd" ];
        };
    };
  };
}
