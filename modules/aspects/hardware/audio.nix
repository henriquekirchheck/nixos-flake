{ den, inputs, ... }:
{
  den.default.includes = [ den.aspects.hardware.audio ];

  den.aspects.hardware.audio.includes = [ den.aspects.hardware.audio.pipewire ];

  den.aspects.hardware.audio.pipewire = {
    nixos.services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    cacheHome = _: {
      directories = [ ".local/state/wireplumber" ];
    };
  };

  flake-file.inputs.musnix = {
    url = "github:musnix/musnix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.aspects.hardware.audio.professional = {
    nixos = { pkgs, ... }: {
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
    };
  };
}
