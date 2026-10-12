{
  den.aspects.apps.media.audio.sone = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.sone ];
    };

    cacheHome = _: {
      directories = [
        ".config/sone"
        ".local/share/io.github.lullabyX.sone"
      ];
    };
  };
}
