{
  config,
  lib,
  pkgs,
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

  # systemd.user.services.mpdris2-rs =
  #   {
  #     Install = {
  #       WantedBy = [ "default.target" ];
  #     };

  #     Unit = {
  #       Description = "D-Bus MPRIS 2 support for MPD";
  #       After = [ "mpd.service" ];
  #     };

  #     Service = {
  #       Type = "dbus";
  #       Restart = "on-failure";
  #       ExecStart = lib.getExe pkgs.mpdris2-rs;
  #       BusName = "org.mpris.MediaPlayer2.mpd";
  #     };
  #   };
  systemd.user.services.mpdas = {
    Install = {
      WantedBy = [ "default.target" ];
    };

    Unit = {
      Description = "mpdas AutoScrobbler";
      After = [ "mpd.service" ];
    };

    Service = {
      ExecStart = lib.getExe pkgs.mpdas;
    };
  };
}
