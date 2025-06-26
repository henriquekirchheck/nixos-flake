{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    raopOpenFirewall = true;
    extraConfig.pipewire."10-airplay"."context.modules" = [
      {
        name = "libpipewire-module-raop-discover";
      }
    ];
  };
}
