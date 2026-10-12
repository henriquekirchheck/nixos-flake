{
  den.aspects.apps.media.images.krita = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.krita ];
    };
    persistHome = _: {
      directories = [
        ".config/krita"
        ".local/share/krita"
      ];
    };
  };
}
