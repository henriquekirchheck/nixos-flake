{
  den.aspects.apps.compatibility.wine = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.wineWow64Packages.waylandFull
          pkgs.winetricks
          (pkgs.writeShellScriptBin "wine64" ''exec wine "$@"'')
        ];
      };

    persistHome = _: {
      directories = [ ".wine" ];
    };
  };
}
