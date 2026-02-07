{ den, ... }:
{
  den.aspects.services.provides.ddclient =
    {
      protocol,
      domains,
      zone,
      sopsFile,
    }:
    {
      description = "DDNS Service";
      includes = [ den.aspects.apps._.sops ];
      nixos =
        { config, ... }:
        {
          sops.secrets.ddclient-token = {
            sopsFile = sopsFile;
            key = "password";
          };
          services.ddclient = {
            enable = true;
            inherit protocol domains zone;
            username = "token";
            passwordFile = config.sops.secrets.ddclient.path;
          };
        };
    };
}
