{ config, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [ steam gamescope mangohud ];
  programs.gamemode.enable = true;
}
