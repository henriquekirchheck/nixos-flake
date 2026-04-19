{ den, ... }:
{
  den.aspects.hardware.provides.scanner = {
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
    provides.permission.user.extraGroups = [
      "lp"
      "scanner"
    ];
  };
}
