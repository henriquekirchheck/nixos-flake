{ den, ... }:
{
  den.aspects.hardware.provides.scanner = {
    includes = [ den.aspects.hardware._.scanner._.permission ];
    nixos =
      { pkgs, ... }:
      {
        hardware.sane = {
          enable = true;
          extraBackends = with pkgs; [
            sane-airscan
            # epkowa
            utsushi
          ];
          disabledDefaultBackends = [ "escl" ];
        };
      };
    provides.permission =
      { user, ... }:
      {
        nixos.users.users.${user.userName}.extraGroups = [
          "lp"
          "scanner"
        ];
      };
  };
}
