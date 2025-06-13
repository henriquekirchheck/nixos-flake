{ config, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    open = false;
    modesetting.enable = false;
    videoAcceleration = true;
  };

  hardware.nvidia-container-toolkit.enable = true;
}
