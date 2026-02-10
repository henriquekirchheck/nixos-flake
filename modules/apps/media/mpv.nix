{
  den.aspects.apps.provides.media.provides.mpv.homeManager = {
    programs.mpv = {
      enable = true;
      config = {
        vo = "gpu-next";
        hwdec = "auto-safe";
        profile = "gpu-hq";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
