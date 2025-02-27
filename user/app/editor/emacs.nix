{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    emacs
    ripgrep
    coreutils
    fd
    clang
  ];
}
