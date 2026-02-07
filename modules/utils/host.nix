{
  den.aspects.utils.provides.host = {
    provides = {
      locale =
        {
          default,
          extra ? default,
        }:
        {
          nixos.i18n = {
            defaultLocale = default;
            extraLocaleSettings = {
              LC_ADDRESS = extra;
              LC_IDENTIFICATION = extra;
              LC_MEASUREMENT = extra;
              LC_MONETARY = extra;
              LC_NAME = extra;
              LC_NUMERIC = extra;
              LC_PAPER = extra;
              LC_TELEPHONE = extra;
              LC_TIME = extra;
            };
          };
        };
    };
  };
}
