{ config, pkgs, lib, ... }:

{
  imports = [
    ../base/home.nix
    ../../user/app/sandboxing/virtualization.nix
    ../../user/app/development/tex.nix
    ../../user/app/development/godot.nix
    ../../user/app/development/blender.nix
    ../../user/app/games/yuzu.nix
    ../../user/app/games/ryujinx.nix
    ../../user/app/games/prismlauncher.nix
    #    ../../user/app/games/mcpelauncher.nix
  ];
}
