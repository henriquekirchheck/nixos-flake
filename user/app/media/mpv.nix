{ config, pkgs, lib, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      ytdl-format = "bestvideo+bestaudio";
    };
  };
  programs.yt-dlp.enable = true;
}
