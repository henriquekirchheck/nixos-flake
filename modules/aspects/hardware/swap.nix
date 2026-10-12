{ den, ... }: {
  den.default.includes = [ den.aspects.hardware.swap ];

  den.aspects.hardware.swap = {
    nixos.boot.kernel.sysctl = {
      "vm.swappiness" = 100;
    };
  };
  den.aspects.hardware.swap.zswap = {
    nixos.boot.zswap = {
      enable = true;
      compressor = "zstd";
      zpool = "zsmalloc";
    };
  };
}
