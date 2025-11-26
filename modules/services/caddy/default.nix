{ pkgs, lib, ... }:

{
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
    package = (
      pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
        hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
      }
    );
  };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
