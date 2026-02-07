{ den, ... }:
{
  den.aspects.hardware.provides.android = {
    includes = [ den.aspects.hardware._.scanner._.permission ];
    nixos =
      { pkgs, ... }:
      {
        programs.adb.enable = true;
        environment.defaultPackages = [ pkgs.jmtpfs ];
      };
    provides.permission =
      { user, ... }:
      {
        nixos.users.users.${user.userName}.extraGroups = [ "adbusers" ];
      };
  };
}
