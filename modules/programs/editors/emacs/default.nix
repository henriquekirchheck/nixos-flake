{ pkgs, config, ... }:
let
  emacs = (pkgs.emacsPackagesFor pkgs.emacs-git-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      # treesit-grammars.with-all-grammars
      vterm
    ]
  );
in
{
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
        en-computers
        en-science
        pt_BR
      ]
    ))
    editorconfig-core-c
    sqlite
    clang-tools
    age
    emacs-lsp-booster
  ];

  services.emacs = {
    enable = true;
    package = emacs;
    client.enable = true;
    socketActivation.enable = true;
  };

  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];
}
