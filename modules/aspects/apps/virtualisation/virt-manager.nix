{ den, ... }:
{
  den.aspects.apps.virtualisation.virt-manager = {
    includes = [ den.aspects.apps.virtualisation.libvirtd ];
    nixos.programs.virt-manager.enable = true;
  };
}
