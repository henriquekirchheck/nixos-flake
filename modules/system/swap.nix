{
  den.aspects.system.provides.swap.provides = {
    zram.nixos.zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
      memoryPercent = 50;
    };
    zswap.nixos.boot.kernelParams = [ "zswap.enabled=1" ];
  };
}
