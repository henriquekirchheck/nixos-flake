{ den, ... }:
{
  den.aspects.apps.provides.virtualisation = {
    description = "Virtualisation";

    nixos =
      { pkgs, ... }:
      {
        virtualisation.libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu;
            swtpm.enable = true;
            vhostUserPackages = [ pkgs.virtiofsd ];
          };
          nss.enableGuest = true;
        };
        boot.binfmt.emulatedSystems = [
          "aarch64-linux"
          "riscv64-linux"
        ];
        environment.systemPackages = [
          pkgs.dnsmasq
        ];
        networking.firewall.trustedInterfaces = [ "virbr0" ];
      };

    provides = {
      qemu = {
        includes = [ den.aspects.apps._.virtualisation ];
        nixos =
          { config, pkgs, ... }:
          let
            qemu = config.virtualisation.libvirtd.qemu.package;
          in
          {
            environment.defaultPackages = [
              qemu
              pkgs.quickemu
            ];
            systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${qemu}/share/qemu/firmware" ];
          };
      };
      virt-manager = {
        includes = [ den.aspects.apps._.virtualisation ];
        nixos.programs.virt-manager.enable = true;
      };

      permission.user.extraGroups = [ "libvirtd" ];
    };
  };
}
