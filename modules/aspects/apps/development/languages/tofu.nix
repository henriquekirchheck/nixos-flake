{
  den.aspects.apps.development.languages.tofu = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.opentofu
        pkgs.tofu-ls
      ];
    };
    zed-extensions = _: [ "opentofu" ];
  };
}
