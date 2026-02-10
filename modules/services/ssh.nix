{ den, ... }:
{
  den.aspects.services.provides.ssh = {
    description = "Secure Shell";

    provides = {
      server = {
        provides = {
          description = "SSH Daemon";

          nixos = {
            services.openssh = {
              enable = true;
              openFirewall = true;
              settings = {
                PermitRootLogin = "no";
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
              };
            };
            services.fail2ban.enable = true;
          };
          allow-user =
            { user, ... }:
            {
              description = "Add user to allow-list";
              nixos.services.openssh.settings.AllowUsers = [ user.userName ];
            };
        };
      };

      client = {
        description = "SSH Client";
        homeManager = {
          programs.ssh = {
            enable = true;
            enableDefaultConfig = false;
            matchBlocks."*".addKeysToAgent = "4h";
          };
        };
        provides = {
          secret-keys =
            {
              sopsFile,
              keyPath ? ".ssh/id_ed25519",
            }:
            {
              description = "Add ssh keys from secret";
              includes = [ den.aspects.apps._.sops ];
              homeManager =
                { config, ... }:
                {
                  sops.secrets.private = {
                    inherit sopsFile;
                    path = "${config.home.homeDirectory}/${keyPath}";
                  };
                  sops.secrets.public = {
                    inherit sopsFile;
                    path = "${config.home.homeDirectory}/${keyPath}.pub";
                  };
                };
            };
          add-host =
            {
              sopsFile,
              secretKey,
              domain,
            }:
            {
              description = "Add host";
              includes = [ den.aspects.apps._.sops ];
              homeManager =
                { config, ... }:
                let
                  secret = "${domain}-ssh";
                in
                {
                  sops.secrets.${secret} = {
                    inherit sopsFile;
                    key = secretKey;
                  };
                  programs.ssh.matchBlocks.${domain} = {
                    host = domain;
                    identitiesOnly = true;
                    identityFile = [ config.sops.secrets.${secret}.path ];
                  };
                };
            };
        };
      };
    };
  };
}
