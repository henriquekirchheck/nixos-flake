{
  den.aspects.apps.media.videos.gpu-screen-recorder = {
    nixos = { pkgs, ... }: {
      programs.gpu-screen-recorder.enable = true;
      environment.systemPackages = [ pkgs.gpu-screen-recorder-gtk ];
    };
  };
}
