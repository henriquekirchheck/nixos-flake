{ config, pkgs, ... }:

{
  # Firewall
  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8096 80 443 ];
  networking.firewall.allowedUDPPorts = [ 8096 80 443 ];
}
