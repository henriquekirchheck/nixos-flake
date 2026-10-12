{ den, lib, ... }: {
  den.default.includes = [ den.aspects.batteries.locale ];
  den.aspects.batteries.locale = {
    settings = {
      default = lib.mkOption {
        description = "The default locale for the system, most strings will be displayed in this locale";
        type = lib.types.str;
      };
      extra = lib.mkOption {
        description = "The extra locale for the system, most units (time, money, measures) will be displayed in this locale";
        type = lib.types.str;
      };
    };
    nixos = { host, ... }: {
      i18n = {
        defaultLocale = host.settings.batteries.locale.default;
        extraLocaleSettings = {
          LC_ADDRESS = host.settings.batteries.locale.extra;
          LC_IDENTIFICATION = host.settings.batteries.locale.extra;
          LC_MEASUREMENT = host.settings.batteries.locale.extra;
          LC_MONETARY = host.settings.batteries.locale.extra;
          LC_NAME = host.settings.batteries.locale.extra;
          LC_NUMERIC = host.settings.batteries.locale.extra;
          LC_PAPER = host.settings.batteries.locale.extra;
          LC_TELEPHONE = host.settings.batteries.locale.extra;
          LC_TIME = host.settings.batteries.locale.extra;
        };
      };
    };
  };
}
