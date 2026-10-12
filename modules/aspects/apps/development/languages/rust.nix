{
  den.aspects.apps.development.languages.rust = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        rustc
        cargo
        rustfmt
        rust-analyzer
        clippy
        cargo-nextest
      ];
      home.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    };
    zed-extensions = _: [ "cargo-tom" ];
    zed-settings = _: [
      {
        languages.Rust.tab_size = 4;
        lsp.rust-analyzer = {
          enable_lsp_tasks = true;
          initialization_options.rust.analyzerTargetDir = true;
        };
      }
    ];
    cacheHome = _: {
      directories = [ ".cargo" ];
    };
  };
}
