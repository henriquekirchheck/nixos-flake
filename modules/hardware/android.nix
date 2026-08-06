{ den, ... }:
{
  den.aspects.hardware.provides.android = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.android-tools
        ];
      };
    provides.permission.user.extraGroups = [ "adbusers" ];
  };
}
