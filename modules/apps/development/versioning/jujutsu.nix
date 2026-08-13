{ den, ... }: {
  den.aspects.apps.provides.development.provides.versioning.provides.jujutsu = {
    description = "Jujutsu VCS";
    homeManager.programs.jujutsu.enable = true;
    provides = {
      include-settings = settings: {
        homeManager.programs.jujutsu.settings = settings;
      };
      include-ssh-signing =
        {
          sopsFile,
          secretKey,
        }:
        {
          description = "Add host";
          includes = [ den.aspects.apps._.sops ];
          homeManager =
            { config, ... }:
            let
              secret = "jj-sign-ssh";
            in
            {
              sops.secrets.${secret} = {
                inherit sopsFile;
                key = secretKey;
              };
              programs.jujutsu.settings.signing = {
                behavior = "own";
                backend = "ssh";
                key = config.sops.secrets.${secret}.path;
              };
            };
        };
    };
  };
}
