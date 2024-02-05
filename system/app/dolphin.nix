{ pkgs, ... }: 
{
  environment.packages = [ pkgs.dolphin-emu ];
  services.udev.packages = [ pkgs.dolphinEmu ];
}
