{
  den.aspects.apps.development.vcs.git = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
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
              lazy = "!${lib.getExe config.programs.lazygit.package}";
            };
          };
          signing.signByDefault = true;
        };

        programs.delta = {
          enable = true;
          enableGitIntegration = true;
        };

        programs.lazygit.enable = true;
      };

    zed-extensions = _: [ "git-firefly" ];
  };
}
