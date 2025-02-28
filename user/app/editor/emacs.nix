{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    emacs
    ripgrep
    coreutils
    fd
  ];
}
