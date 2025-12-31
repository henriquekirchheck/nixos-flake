{
  imports = [ ./module.nix ];
  programs.mpris-scrobbler = {
    enable = true;
    verbosity = "v";
  };
}
