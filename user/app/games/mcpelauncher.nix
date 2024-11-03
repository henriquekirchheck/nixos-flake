{ config, pkgs, ... }:
let
  version = "v0.15.0";
  revision = "795";
  arch = "x86_64";
  mcpelauncher = pkgs.appimageTools.wrapType2 {
    name = "mcpelauncher";
    src = pkgs.fetchurl {
      url = "https://github.com/minecraft-linux/appimage-builder/releases/download/${version}-${revision}/Minecraft_Bedrock_Launcher-${arch}-${version}.${revision}.AppImage";
      hash = "sha256-tp5+99kFspJ1XGtTw+FUhFFgW4EhiV4/+6ysQ91lqKY=";
    };
    extraPkgs = pkgs: with pkgs; [ ];
  };
in
{
  home.packages = [ mcpelauncher ];
}
