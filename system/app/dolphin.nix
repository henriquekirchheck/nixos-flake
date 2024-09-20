{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.dolphin-emu ];
  services.udev.packages = [ pkgs.dolphinEmu ];
}
