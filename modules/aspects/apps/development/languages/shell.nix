{
  den.aspects.apps.development.languages.shell = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.fish-lsp
        pkgs.bash-language-server
        pkgs.shfmt
      ];
    };
    zed-extensions = _: [
      "fish"
      "basher"
    ];
    zed-settings = _: [
      {
        languages."Shell Script" = {
          formatter.external = {
            command = "shfmt";
            arguments = [
              "--filename"
              "{buffer_path}"
              "--indent"
              "2"
            ];
          };
        };
      }
    ];
  };
}
