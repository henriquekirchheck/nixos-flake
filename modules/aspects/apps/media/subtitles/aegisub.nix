{
  den.aspects.apps.media.subtitles.aegisub = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.aegisub ];
    };
  };
}
