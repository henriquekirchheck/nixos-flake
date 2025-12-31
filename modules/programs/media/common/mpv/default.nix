{
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      hwdec = "auto-safe";
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
    };
  };
  programs.yt-dlp.enable = true;
}
