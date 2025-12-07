{
  inputs,
  pkgs,
  ...
}:

{
  system.stateVersion = "24.05";

  nix = {
    package = pkgs.lix;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      home-manager.flake = inputs.home-manager;
      nixos-config.flake = inputs.self;
    };
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "home-manager=${inputs.home-manager}"
      "nixos-config=${inputs.self}"
      "${inputs.nixpkgs}"
    ];
  };

  environment.packages = with pkgs; [
    neovim
    wget
    aria2
    eza
    fd
    ripgrep
    btop
    htop
    mpv
    file
    pv
    zip
    unzip
    rar
    p7zip
    ouch
    dos2unix
    rename
    appimage-run
    jq
    procs
    ncdu
    dust
    hyperfine
    pandoc
    dua
    rsync
    sops
    age
    ssh-to-age
    fastfetch
    onefetch
    lolcat
    cowsay
    gnugrep
    gnused
    killall
    libnotify
    bat
    fzf
    nix-output-monitor
    tealdeer
    httpie
    libqalculate
  ];

  time.timeZone = "America/Sao_Paulo";
}
