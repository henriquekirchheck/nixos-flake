{
  den.aspects.apps.provides.media.provides.mpv.homeManager = { pkgs, ... }: {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          mpris
          thumbfast
          quality-menu
          bdanmaku
          uosc
          sponsorblock
        ];
      };
      config = {
        vo = "gpu-next";
        hwdec = "auto-safe";
        profile = "gpu-hq";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
