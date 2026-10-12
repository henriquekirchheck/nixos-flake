{
  den.aspects.apps.virtualisation.qemu = {
    nixos =
      {
        config,
        pkgs,
        ...
      }:
      let
        qemu =
          if config.virtualisation.libvirtd.enable then
            config.virtualisation.libvirtd.qemu.package
          else
            pkgs.qemu;
      in
      {
        environment.systemPackages = [ qemu ];
        systemd.tmpfiles.settings.qemu."/var/lib/firmware"."L+".argument = "${qemu}/share/qemu/firmware";
        boot.binfmt.emulatedSystems = [
          "aarch64-linux"
          "riscv64-linux"
        ];
      };
  };
}
