{ inputs, den, ... }:
{
  flake-file.inputs.musnix = {
    url = "github:musnix/musnix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.aspects.hardware.provides.audio.provides.professional = {
    includes = [ den.aspects.hardware._.audio._.professional._.permission ];

    nixos =
      { pkgs, ... }:
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
      };
    provides.permission =
      { user, ... }:
      {
        nixos.users.users.${user.userName}.extraGroups = [
          "audio"
          "rt"
        ];
      };
  };
}
