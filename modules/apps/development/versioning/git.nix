{ den, ... }:
{
  den.aspects.apps.provides.development.provides.versioning.provides.git = {
    description = "Git";
    homeManager =
      { pkgs, ... }:
      {
        programs.git = {
          enable = true;
          package = pkgs.gitFull;
          settings = {
            init.defaultBranch = "main";
            pull.rebase = true;
          };
          signing = {
            format = "ssh";
            signByDefault = true;
          };
        };
      };

    provides = {
      include-settings = settings: {
        homeManager.programs.git.settings = settings;
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
              secret = "git-sign-ssh";
            in
            {
              sops.secrets.${secret} = {
                inherit sopsFile;
                key = secretKey;
              };
              programs.git.signing.key = config.sops.secrets.${secret}.path;
            };
        };
      delta = {
        description = "Delta diff";
        homeManager.programs.delta = {
          enable = true;
          enableGitIntegration = true;
        };
      };
      gh = {
        description = "GitHub CLI";
        homeManager.programs.gh = {
          enable = true;
          settings.git_protocol = "ssh";
        };
      };
    };
  };
}
