{ config, pkgs, ... }:

{
  # Enable printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ epson-escpr ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
}
