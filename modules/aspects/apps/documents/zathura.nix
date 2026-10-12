{
  den.aspects.apps.documents.zathura = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.zathura ];
    };
  };
}
