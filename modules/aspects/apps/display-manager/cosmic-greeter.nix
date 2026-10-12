{
  den.aspects.apps.display-managers.cosmic-greeter = {
    nixos.services.displayManager.cosmic-greeter.enable = true;
    cache = _: {
      directories = [ "/var/lib/cosmic-greeter" ];
    };
  };
}
