{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ yt-dlp mpv jellyfin-mpv-shim ];
  programs.mpv = {
    enable = true;
    config = {

      ytdl-format = "bestvideo+bestaudio";
    };
  };
  programs.yt-dlp.enable = true;
}