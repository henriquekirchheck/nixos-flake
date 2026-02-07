{
  den.aspects.hardware.provides.networking.provides.avahi = {
    nixos = {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
