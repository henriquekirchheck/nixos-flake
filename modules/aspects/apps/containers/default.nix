{
  den.aspects.apps.containers = {
    nixos = { config, ... }: {
      virtualisation.containers = {
        enable = true;
        registries.settings.registry = [
          { location = "docker.io"; }
          { location = "quay.io"; }
        ];
      };

      hardware.nvidia-container-toolkit.enable = config.hardware.nvidia.enabled;
    };

    persist = _: {
      directories = [ "/var/lib/containers" ];
    };
    persistHome = _: {
      directories = [ ".local/share/containers" ];
    };
  };
}
