{ config, pkgs, lib, ... }:

{
  imports = [
    ../base/home.nix
    ../../user/app/sandboxing/virtualization.nix
    ../../user/app/games/yuzu.nix
    ../../user/app/games/ryujinx.nix
    ../../user/app/games/prismlauncher.nix
  ];
  programs.waybar.mainBar.modules-right = [ "backlight" ];
}
