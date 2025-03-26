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
    ../../system/extras/caddy/caddy.nix
  ];

  environment.systemPackages = with pkgs; [ cloudflared ];
  services.cloudflared = {
    enable = true;
    tunnels = {
      "52ba507f-2e7c-4527-9010-aaa4ff579fa2" = {
        credentialsFile = "/root/.cloudflared/52ba507f-2e7c-4527-9010-aaa4ff579fa2.json";
        #ingress = let
        #  bases = [
        #    "files"
        #    "jf"
        #    "qbit"
        #    "radarr"
        #    "sonnar"
        #    "lidarr"
        #    "readarr"
        #    "prowlarr"
        #    "bazarr"
        #  ];
        #in (builtins.listToAttrs (map (base:
        #  let host = "${base}.tunnel.henriquekh.dev.br";
        #  in {
        #    name = host;
        #    value = {
        #      service = "http://localhost";
        #      originRequest = {
        #        httpHostHeader = host;
        #        originServerName = "henriquekh.dev.br";
        #      };
        #    };
        #  }) bases)) // {
        #    "ssh.tunnel.henriquekh.dev.br" = "ssh://localhost:22";
        #  };
        ingress = {
          "jf.tunnel.henriquekh.dev.br" = "http://localhost:8096";
          "jelly.henriquekh.dev.br" = "http://localhost:8096";
          "vault.henriquekh.dev.br" = "http://localhost:8179";
          "search.henriquekh.dev.br" = "http://localhost:5947";
          "app.tunnel.henriquekh.dev.br" = "http://localhost:3000";
        };
        default = "http_status:404";
      };
    };
  };
}
