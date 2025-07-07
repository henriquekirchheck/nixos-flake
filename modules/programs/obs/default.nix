{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = config.hardware.nvidia.enabled;
    };
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-vaapi
      obs-gstreamer
      obs-pipewire-audio-capture
      obs-livesplit-one
      obs-backgroundremoval
      input-overlay
      droidcam-obs
    ];
    enableVirtualCamera = true;
  };
}
