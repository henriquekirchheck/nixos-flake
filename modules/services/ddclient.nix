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
        let
          secret = "ddclient-token";
        in
        {
          sops.secrets.${secret} = {
            inherit sopsFile;
            key = "password";
          };
          services.ddclient = {
            enable = true;
            inherit protocol domains zone;
            username = "token";
            passwordFile = config.sops.secrets.${secret}.path;
          };
          # Temporary fix to https://github.com/NixOS/nixpkgs/issues/350408
          # Found in https://discourse.nixos.org/t/seeking-advice-on-how-to-fix-ddclient-service-dependencies/74171
          systemd.services.ddclient.after = [ "nss-user-lookup.target" ];
        };
    };
}
