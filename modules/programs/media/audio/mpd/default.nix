{
  config,
  lib,
  osConfig,
  ...
}:

{
  services.mpd = {
    enable = true;
    musicDirectory = lib.mkIf (
      osConfig.networking.hostName == "henrique-pc"
    ) "/vol/drive/containers/media/data/media/music";
    network.startWhenNeeded = true;
    playlistDirectory = "${config.xdg.userDirs.music}/playlists";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };
  services.mpd-discord-rpc.enable = true;
  services.mpd-mpris.enable = true;
}
