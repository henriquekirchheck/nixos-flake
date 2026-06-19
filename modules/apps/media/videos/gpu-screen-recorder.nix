{
  den.aspects.apps.provides.media.provides.videos.provides.gpu-screen-recorder = {
    nixos =
      { pkgs, ... }:
      {
        programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GUI
        environment.systemPackages = [ pkgs.gpu-screen-recorder-gtk ]; # GUI app
      };
  };
}
