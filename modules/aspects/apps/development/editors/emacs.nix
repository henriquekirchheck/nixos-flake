{ inputs, ... }:
{
  flake-file.inputs.emacs-overlay = {
    url = "github:nix-community/emacs-overlay";
    inputs.nixpkgs-stable.follows = "";
  };

  den.aspects.apps.development.editors.emacs = {
    nixpkgs-overlays = _: [ inputs.emacs-overlay.overlays.default ];
    homeManager = { pkgs, config, ... }: {
      home.packages = with pkgs; [
        binutils
        emacs
        ripgrep
        gnutls
        perl
        wget
        fd
        imagemagick
        zstd
        (aspellWithDicts (
          ds: with ds; [
            en
            pt_BR
          ]
        ))
        editorconfig-core-c
        sqlite
        clang-tools
        age
        emacs-lsp-booster
        graphviz
      ];

      services.emacs =
        let
          emacs = (pkgs.emacsPackagesFor pkgs.emacs-git-pgtk).emacsWithPackages (
            epkgs: with epkgs; [
              treesit-grammars.with-all-grammars
              vterm
            ]
          );
        in
        {
          enable = true;
          package = emacs;
          client.enable = true;
          socketActivation.enable = true;
        };

      home.sessionPath = [
        "${config.xdg.configHome}/emacs/bin"
      ];
    };
  };
}
