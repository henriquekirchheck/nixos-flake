{ den, ... }:
{
  den.aspects.apps.provides.cli = {
    includes = [
      (den._.unfree [
        "unrar"
        "rar"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          wget
          eza
          fd
          ripgrep
          btop
          htop
          file
          pv
          zip
          unzip
          unrar
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
          hwinfo
          pciutils
          nix-output-monitor
          tealdeer
          httpie
          libqalculate
        ];
      };
  };
}
