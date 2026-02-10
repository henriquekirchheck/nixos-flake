{ den, ... }:
{
  den.aspects.hardware.provides.android = {
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
