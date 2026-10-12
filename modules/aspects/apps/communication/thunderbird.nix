{
  den.aspects.apps.communication.thunderbird = {
    homeManager = { pkgs, ... }: {
      programs.thunderbird = {
        enable = true;
        package = pkgs.thunderbird-latest;
        settings = {
          "privacy.donottrackheader.enabled" = true;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
    persistHome = _: {
      directories = [ ".thunderbird" ];
    };
  };
}
