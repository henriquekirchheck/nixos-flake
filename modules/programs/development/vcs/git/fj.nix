{
  imports = [ ./modules/forgejo-cli.nix ];

  programs.forgejo-cli = {
    enable = true;
    hosts."codeberg.org".name = "henriquekh";
    defaultSSH = [
      "codeberg.org"
    ];
  };

  home.shellAliases = {
    "fjc" = "fj --host codeberg.org";
  };
}
