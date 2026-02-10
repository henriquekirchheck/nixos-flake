{ den, ... }:
{
  den.aspects.services.provides.caddy = {
    description = "Caddy HTTP Server";

    nixos.services.caddy = {
      enable = true;
      openFirewall = true;
    };

    provides = {
      withPlugins = plugins: {
        description = "Add plugins to caddy package";
        includes = [ den.aspects.services._.caddy ];
        nixos =
          { pkgs, ... }:
          {
            services.caddy.package = pkgs.caddy.withPlugins plugins;
          };
      };
      includeEnvironment = sopsFile: {
        description = "Include secret as environment variable file";
        includes = [ den.aspects.apps._.sops ];
        nixos =
          { config, ... }:
          {
            sops.secrets.caddy_env = {
              inherit sopsFile;
              format = "dotenv";
              key = "";
              owner = config.services.caddy.user;
            };
            services.caddy.environmentFile = config.sops.secrets.caddy_env.path;
          };
      };
      includeGlobal = global: {
        description = "Include global configuration";
        nixos.services.caddy.globalConfig = global;
      };
      addVirtualHost = vhosts: config: {
        description = "Add Virtual Host configuration to Caddy";
        nixos =
          { lib, ... }:
          {
            services.caddy.virtualHosts.${builtins.elemAt vhosts 0} = {
              serverAliases = lib.sublist 1 ((lib.length vhosts) - 1) vhosts;
              extraConfig = config;
            };
          };
      };
    };
  };
}
