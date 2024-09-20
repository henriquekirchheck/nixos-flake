{ config, pkgs, lib, ... }:

{
  home.packages = [
    (pkgs.retroarch.override {
      cores = with pkgs.libretro; [
        snes9x
        prboom
        melonds
        dolphin
        citra
        bsnes-hd
        mupen64plus
      ];
    })
  ];
}
