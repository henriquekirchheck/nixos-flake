{ config, pkgs, lib, ... }:

{
  home.packages = [
    (pkgs.buildFHSUserEnv {
      name = "zed";
      targetPkgs = pkgs: [ pkgs.zed-editor ];
      runScript = "zed";
    })
  ];
}
