{ pkgs, lib, ... }:

{
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
    package = (
      pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare" ];
        hash = lib.fakeSha256;
      }
    );
  };
}
