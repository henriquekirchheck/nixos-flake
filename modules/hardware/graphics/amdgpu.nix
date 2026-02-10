{ den, ... }:
{
  den.aspects.hardware.provides.graphics.provides.amdgpu = {
    includes = [ den.aspects.hardware._.graphics ];
    nixos = {
      hardware.amdgpu.opencl.enable = true;
    };
  };
}
