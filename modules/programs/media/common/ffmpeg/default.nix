{ pkgs, osConfig, ... }:

let
  ffmpeg =
    if osConfig.hardware.nvidia.enabled then
      (pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: {
        doCheck = false;
      })
    else
      pkgs.ffmpeg-full;
in
{
  home.packages = [ ffmpeg ];
}
