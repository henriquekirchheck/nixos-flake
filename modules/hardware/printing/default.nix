{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprint-bin
      epson-escpr2
      epson-escpr
    ];
  };
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      sane-airscan
      # epkowa
      utsushi
    ];
    disabledDefaultBackends = [ "escl" ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
