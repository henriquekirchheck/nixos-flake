{ inputs, pkgs, ... }:

{
  imports = [ inputs.musnix.nixosModules.musnix ];
  musnix = {
    enable = true;
    rtcqs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    yabridge
    yabridgectl
    x42-plugins
    chow-tape-model
    chow-kick
    chow-centaur
    chow-phaser
    surge
    carla
    zam-plugins
    zlcompressor
    zlequalizer
    zlsplitter
    oxefmsynth
    autotalent
  ];
}
