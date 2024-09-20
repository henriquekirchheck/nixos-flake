{ config, pkgs, ... }:

{
  # Enable printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
