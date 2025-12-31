{
  config,
  ...
}:

{
  programs.aria2 = {
    enable = true;
    settings = {
      dir = config.xdg.userDirs.download;
      seed-ratio = 5.0;
      seed-time = 240;
      ftp-pasv = true;
      disk-cache = "32M";
      file-allocation = "falloc";
      continue = true;
      max-concurrent-downloads = 10;
      max-connection-per-server = 16;
      follow-torrent = true;
      min-split-size = "10M";
      split = 5;
      enable-peer-exchange = true;
      bt-hash-check-seed = true;
      bt-seed-unverified = true;
      bt-save-metadata = false;
    };
  };
}
