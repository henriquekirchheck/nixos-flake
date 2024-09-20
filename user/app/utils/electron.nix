{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ electron ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
