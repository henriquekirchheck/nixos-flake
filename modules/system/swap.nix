{
  den.aspects.system.provides.swap = {
    nixos.boot.kernel.sysctl = {
      "vm.swappiness" = 100;
    };
    provides = {
      zswap.nixos.boot.zswap = {
        enable = true;
        compressor = "zstd";
        zpool = "zsmalloc";
      };
    };
  };
}
