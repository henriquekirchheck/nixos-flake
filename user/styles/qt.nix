{ config, pkgs, lib, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
