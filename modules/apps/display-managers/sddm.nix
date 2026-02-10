{
  den.aspects.apps.provides.display-managers.provides.sddm.nixos = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings.General.Numlock = "on";
    };
  };
}
