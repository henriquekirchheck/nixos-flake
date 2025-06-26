{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
      obs-livesplit-one
      obs-backgroundremoval
      input-overlay
      droidcam-obs
    ];
    enableVirtualCamera = true;
  };
}
