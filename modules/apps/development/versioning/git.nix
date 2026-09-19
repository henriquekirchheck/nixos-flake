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
            core = {
              compression = 9;
              whitespace = "error";
              preloadindex = true;
            };
            init.defaultBranch = "main";
            status = {
              branch = true;
              showStash = true;
              showUntrackedFiles = "all";
            };
            log.abbrevCommit = true;
            branch.sort = "-committerdate";
            tag.sort = "-taggerdate";
            pager = {
              branch = false;
              tag = false;
            };
            push = {
              autoSetupRemote = true;
              default = "current";
              followTags = true;
            };
            pull = {
              default = "current";
              rebase = true;
            };
            rebase = {
              autoStash = true;
              missingCommitsCheck = "warn";
            };
            rerere = {
              enabled = true;
              autoupdate = true;
            };
            diff = {
              algorithm = "histogram";
              colorMoved = "default";
              mnemonicPrefix = true;
            };
            interactive.singlekey = true;
            merge.conflictStyle = "zdiff3";
            alias = {
              d = "diff";
              s = "status";
              a = "add";
              ap = "add -p";
              c = "commit";
              l = "log --all --graph --oneline";
              cl = "clone";
            };
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
      lazy = {
        description = "LazyGit";
        homeManager = { config, lib, ... }: {
          programs.lazygit.enable = true;
          programs.git.settings.alias.lazy = "!${lib.getExe config.programs.lazygit.package}";
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
