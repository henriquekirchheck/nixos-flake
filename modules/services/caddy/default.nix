{ pkgs, lib, ... }:

{
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
    package = (
      pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
        hash = lib.fakeSha256;
      }
    );
  };
}
