# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../base/configuration.nix
      ../../system/hardware/nvidia.nix
      ../../system/app/virtualization.nix
      ../../system/app/obs.nix
      ../../system/security/sshd.nix
    ];
}
