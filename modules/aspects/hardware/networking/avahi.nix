{
  den.aspects.hardware.networking.avahi = {
    nixos = {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
