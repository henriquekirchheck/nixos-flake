{
  pkgs,
  config,
  lib,
  username,
  name,
  ...
}:

{
  programs.thunderbird = {
    enable = true;
    profiles."$username" = {
      isDefault = true;
    };
  };
}
