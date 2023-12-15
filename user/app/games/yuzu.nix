{ config, pkgs, lib, ... }:

let
  yuzu = pkgs.yuzu-early-access;
  xwrapper = ''
    #!/bin/sh
    QT_QPA_PLATFORM=xcb ${"${yuzu}/bin/yuzu"}
  '';
in {
  home.packages = [
    yuzu
    (pkgs.writeScriptBin "xyuzu" xwrapper)
  ];
}