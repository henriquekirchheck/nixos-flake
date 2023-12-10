{ config, pkgs, lib, ... }:

{
  imports = [
    ../base/home.nix
    ../../user/hardware/bluetooth.nix
  ];
}
