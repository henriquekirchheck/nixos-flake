{ config, pkgs, ... }:

{
  networking = {
    enableIPv6 = true;

    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "9.9.9.9" ];
    dhcpcd = {
      enable = true;
      IPv6rs = true;
      extraConfig = "nohook resolve.conf";
    };
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
