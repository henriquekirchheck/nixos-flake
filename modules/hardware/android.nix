{ den, ... }:
{
  den.aspects.hardware.provides.android = {
    # TODO: Fix when https://github.com/vic/den/issues/145 resolved
    # includes = [ den.aspects.hardware._.android._.permission ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.jmtpfs
          pkgs.android-tools
        ];
      };
    provides.permission =
      { user, ... }:
      {
        nixos.users.users.${user.userName}.extraGroups = [ "adbusers" ];
      };
  };
}
