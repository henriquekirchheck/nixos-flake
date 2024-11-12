{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "9.9.9.9"
    ];
    dhcpcd.extraConfig = "nohook resolve.conf";
  };
  services.zerotierone = {
    enable = true;
    package = pkgs.zerotierone;
  };
  #services.tailscale = {
  #  enable = true;
  #  useRoutingFeatures = "both";
  #};
}
