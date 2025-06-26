{
  pkgs,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.kernelParams = [
    "zswap.enabled=1"
    "psi=1"
  ];
  services.earlyoom.enable = true;
}
