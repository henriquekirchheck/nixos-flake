{ den, ... }:
{
  den.aspects.hardware.provides.printer = {
    includes = [ den.aspects.hardware._.networking._.avahi ];
    nixos =
      { pkgs, ... }:
      {
        services.printing = {
          enable = true;
          drivers = with pkgs; [
            gutenprint
            gutenprint-bin
            epson-escpr2
            epson-escpr
          ];
        };
      };
    provides.permission =
      { user, ... }:
      {
        nixos.users.users.${user.userName}.extraGroups = [ "lp" ];
      };
  };
}
