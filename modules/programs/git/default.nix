{
  programs.git = {
    enable = true;
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
