{
  den.aspects.apps.fetch.hyfetch = {
    homeManager = { config, lib, ... }: {
      programs.hyfetch = {
        enable = true;
        settings = {
          preset = "transgender";
          mode = "rgb";
          lightness = 0.65;
          light_dark = "dark";
          auto_detect_light_dark = true;
          color_align.mode = "horizontal";
          pride_month_disable = false;
          backend = lib.mkIf config.programs.fastfetch.enable "fastfetch";
        };
      };
    };
  };
}
