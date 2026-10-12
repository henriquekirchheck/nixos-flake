{
  den.aspects.apps.development.languages.c-cpp = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        gcc
        gnumake
        cmake
        neocmakelsp
        meson
        autoconf
        automake
        libtool
        clang-tools
      ];
    };

    zed-settings = _: [
      {
        lsp.cmake.initialization_options = {
          format.enable = true;
          lint.enable = true;
        };
      }
      {
        languages.Meson.language_servers = [
          "mesonlsp"
          "!muon"
        ];
      }
    ];
    zed-extensions = _: [
      "meson"
      "neocmake"
      "make"
    ];
  };
}
