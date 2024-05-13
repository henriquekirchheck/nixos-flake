# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./base-config.nix
    ../../system/hardware/nvidia.nix
    ../../system/hardware/android.nix
    ../../system/app/virtualization.nix
    ../../system/app/obs.nix
    ../../system/app/deluge.nix
    ../../system/security/sshd.nix
  ];
}
