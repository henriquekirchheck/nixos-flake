{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.zerotierone.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = true;
  };
}
