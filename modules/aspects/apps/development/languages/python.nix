{
  den.aspects.apps.development.languages.python = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.python3
        pkgs.uv
        pkgs.ruff
        pkgs.pyrefly
      ];
    };
    zed-extensions = _: [ "pyrefly" ];
    zed-settings = _: [
      {
        languages.Python = {
          tab_size = 4;
          language_servers = [
            "ruff"
            "pyrefly"
          ];
          code_actions_on_format = {
            "source.organizeImports.ruff" = true;
          };
          formatter.language_server.name = "ruff";
        };
      }
    ];
  };
}
