# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../base/configuration.nix
    ../../system/hardware/nvidia.nix
    ../../system/hardware/android.nix
    ../../system/app/virtualization.nix
    ../../system/app/obs.nix
    ../../system/security/sshd.nix
  ];

  environment.systemPackages = with pkgs; [ cloudflared ];
  services.cloudflared = {
    enable = true;
    tunnels = {
      "52ba507f-2e7c-4527-9010-aaa4ff579fa2" = {
        credentialsFile = "/root/.cloudflared/52ba507f-2e7c-4527-9010-aaa4ff579fa2.json";
        ingress = {
          "jf.tunnel.henriquekh.dev.br" = "http://localhost:8096";
        };
        default = "http_status:404";
      };
    };
    user = "root";
    group = "root";
  };
}
