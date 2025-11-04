{ pkgs, lib, ... }:

{
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
    package = (
      pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
        hash = "sha256-4qUWhrv3/8BtNCi48kk4ZvbMckh/cGRL7k+MFvXKbTw=";
      }
    );
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
