{ config, pkgs, ... }:
let
  version = "v0.14.1.304";
  mcpelauncher = pkgs.appimageTools.wrapType2 {
    name = "mcpelauncher";
    src = pkgs.fetchurl {
      url =
        "https://github.com/minecraft-linux/mcpelauncher-manifest/releases/download/nightly/Minecraft_Bedrock_Launcher-x86_64-${version}.AppImage";
      hash = "sha256-F8j4SVH7jFgBzscC6m5JjzmPlq3/OBic2zPW6RrteFs=";
    };
    extraPkgs = pkgs: with pkgs; [ ];
  };
in { home.packages = [ mcpelauncher ]; }
