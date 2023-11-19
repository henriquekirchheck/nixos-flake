{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ yt-dlp mpv jellyfin-mpv-shim ];
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      ytdl-format = "bestvideo+bestaudio";
    };
  };
  programs.yt-dlp.enable = true;
}