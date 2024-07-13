{ config, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [ mangohud ];
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
