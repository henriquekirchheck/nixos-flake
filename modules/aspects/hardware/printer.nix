{ den, ... }:
{
  den.aspects.hardware.printer = {
    includes = [ den.aspects.hardware.networking.avahi ];
    nixos = { pkgs, ... }: {
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

    permission.user.extraGroups = [ "lp" ];

    cache = _: {
      directories = [ "/var/lib/cups" ];
    };
  };
}
