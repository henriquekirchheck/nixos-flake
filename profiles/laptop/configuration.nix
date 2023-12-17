# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../base/configuration.nix
      ../../system/hardware/bluetooth.nix
      ../../system/hardware/amd-gpu.nix
      ../../system/hardware/backlight.nix
      ../../system/wm/kde.nix
    ];
}
