{ den, ... }:
{
  den.aspects.services.provides.ssh = {
    description = "Secure Shell";

    provides = {
      server = {
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
        provides = {
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
            settings."Host *".AddKeysToAgent = "4h";
          };
        };
        provides = {
          secret-keys =
            {
              sopsFile,
              keyName,
              keyPath ? ".ssh/id_ed25519",
            }:
            {
              description = "Add ssh keys from secret";
              includes = [ den.aspects.apps._.sops ];
              homeManager =
                { config, ... }:
                {
                  sops.secrets."${keyName}-ssh-private" = {
                    inherit sopsFile;
                    key = "private";
                    path = "${config.home.homeDirectory}/${keyPath}";
                  };
                  sops.secrets."${keyName}-ssh-public" = {
                    inherit sopsFile;
                    key = "public";
                    path = "${config.home.homeDirectory}/${keyPath}.pub";
                  };
                };
            };
          add-host =
            {
              sopsFile,
              secretKey,
              domain,
              extraConfig ? { },
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
                  programs.ssh.settings."Host ${domain}" = {
                    IdentitiesOnly = true;
                    IdentityFile = [ config.sops.secrets.${secret}.path ];
                  }
                  // extraConfig;
                };
            };
        };
      };
    };
  };
}
