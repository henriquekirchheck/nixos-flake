{ pkgs, ... }:

{
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
    package = (
      pkgs.callPackage ../../../packages/caddy.nix {
        externalPlugins = [
          {
            name = "caddy-dns/cloudflare";
            repo = "github.com/caddy-dns/cloudflare";
            version = "89f16b99c18ef49c8bb470a82f895bce01cbaece";
          }
        ];
        vendorHash = "sha256-fTcMtg5GGEgclIwJCav0jjWpqT+nKw2OF1Ow0MEEitk=";
      }
    );
  };
}
