{
  den.aspects.apps.media.videos.obs = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        programs.obs-studio = {
          enable = true;
          package = lib.mkMerge [
            pkgs.obs-studio
            #(lib.mkIf (!config.hardware.nvidia.enabled) pkgs.obs-studio)
            #(lib.mkIf (config.hardware.nvidia.enabled) pkgs.pkgsCuda.obs-studio)
          ];
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-vkcapture
            obs-vaapi
            obs-gstreamer
            obs-pipewire-audio-capture
            obs-livesplit-one
            obs-backgroundremoval
            input-overlay
            # droidcam-obs
          ];
          enableVirtualCamera = true;
        };
      };

    persistHome = _: {
      directories = [ ".config/obs-studio" ];
    };
  };
}
