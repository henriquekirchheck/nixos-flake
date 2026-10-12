{
  den.aspects.apps.development.languages.nix = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.nixfmt
        pkgs.nixd
        pkgs.nil
      ];
    };

    zed-extensions = _: [ "nix" ];
    zed-settings = _: [
      {
        lsp = {
          nixd.initialization_options = {
            formatting.command = [ "nixfmt" ];
            nixpkgs.expr = "import <nixpkgs> { }";
            homeManager.expr = "import <home-manager> { }";
          };
          nil.initialization_options = {
            formatting.command = [ "nixfmt" ];
            nix.flake = {
              autoArchive = true;
              autoEvalInputs = true;
            };
          };
        };
      }
      {
        languages.Nix.language_servers = [
          "nixd"
          "nil"
        ];
      }
    ];
  };
}
