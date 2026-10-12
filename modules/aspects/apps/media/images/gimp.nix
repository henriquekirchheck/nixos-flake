{
  den.aspects.apps.media.images.gimp = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.gimp-with-plugins ];
    };
    persistHome = _: {
      directories = [ ".config/GIMP" ];
    };
  };
}
