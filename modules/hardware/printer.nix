{ den, ... }:
{
  den.aspects.hardware.provides.printer = {
    includes = [
      den.aspects.hardware._.networking._.avahi
      # TODO: Fix when https://github.com/vic/den/issues/145 resolved  
      # den.aspects.hardware._.printer._.permission
    ];
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
