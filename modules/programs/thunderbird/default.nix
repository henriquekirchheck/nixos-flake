{
  pkgs,
  ...
}:

{
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-latest;
    nativeMessagingHosts = [ ];
    settings = {
      "privacy.donottrackheader.enabled" = true;
      "extensions.autoDisableScopes" = 0;
    };

    profiles.user = {
      isDefault = true;
    };
  };
}
