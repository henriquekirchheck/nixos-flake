{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
