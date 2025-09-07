{ pkgs, lib, ... }:

{
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
    package = (
      pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
        hash = "sha256-AcWko5513hO8I0lvbCLqVbM1eWegAhoM0J0qXoWL/vI=";
      }
    );
  };
}
