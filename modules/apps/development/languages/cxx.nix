{
  den.aspects.apps.provides.development.provides.languages.provides.cxx.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gcc
        gnumake
        cmake
        meson
        autoconf
        automake
        libtool
        clang-tools
      ];
    };
}
