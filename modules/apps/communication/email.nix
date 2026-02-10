{
  den.aspects.apps.provides.communication.provides.email = {
    description = "Email";

    provides = {
      add-email =
        {
          name,
          flavor,
          realName,
          address,
          sopsFile,
          secretKey,
          primary ? false,
        }:
        {
          homeManager =
            { config, ... }:
            let
              secret = "${name}-email";
            in
            {
              sops.secrets.${secret} = {
                inherit sopsFile;
                key = secretKey;
              };
              accounts.email.accounts.${name} = {
                inherit
                  primary
                  realName
                  address
                  flavor
                  ;
                smtp.tls.useStartTls = true;
                passwordCommand = "cat ${config.sops.secrets.${secret}.path}";
              };
            };
        };
      thunderbird =
        let
          profile = "user";
        in
        {
          homeManager =
            { pkgs, ... }:
            {
              programs.thunderbird = {
                enable = true;
                package = pkgs.thunderbird-latest;
                settings = {
                  "privacy.donottrackheader.enabled" = true;
                  "extensions.autoDisableScopes" = 0;
                };
                profiles.${profile} = {
                  isDefault = true;
                };
              };
            };

          provides.add-account = name: {
            homeManager = {
              accounts.email.accounts.${name}.thunderbird.enable = true;
              programs.thunderbird.profiles.${profile}.accountsOrder = [ name ];
            };
          };
        };
    };
  };
}
