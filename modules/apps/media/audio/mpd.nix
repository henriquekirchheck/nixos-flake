{
  den.aspects.apps.provides.media.provides.audio.provides.mpd =
    let
      address = "127.0.0.1";
      port = 6600;
    in
    {
      description = "Music Player Daemon";
      nixos = {
        services.mpd = {
          enable = true;
          settings = {
            bind_to_address = address;
            inherit port;
          };
        };
      };
      homeManager =
        {
          config,
          ...
        }:
        {
          services.mpd = {
            enable = true;
            network.startWhenNeeded = true;
            playlistDirectory = "${config.xdg.userDirs.music}/playlists";

            extraConfig = ''
              audio_output {
                type "pipewire"
                name "PipeWire Sound Server"
              }

              database {
                plugin "proxy"
                host "${address}"
                port ${toString port}
              }
            '';
          };
          services.mpd-discord-rpc.enable = true;
          services.mpd-mpris.enable = true;
        };
      provides.setupMusicDir = musicDir: {
        description = "Setups music dir for mpd";
        nixos.services.mpd.settings.music_directory = musicDir;
        homeManager.services.mpd.music_directory = musicDir;
      };
    };
}
