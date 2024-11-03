{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu";
      hwdec = "auto";
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
    };
  };
  programs.yt-dlp.enable = true;
  home.packages = [ pkgs.jellyfin-mpv-shim ];
}
