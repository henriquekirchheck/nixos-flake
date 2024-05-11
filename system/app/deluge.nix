{ config, pkgs, ... }:

{
  services.deluge = {
    enable = true;
    web = {
      enable = true;
      openFirewall = true;
    };
    declarative = true;
    openFirewall = true;
    config.download_location = "/vol/drive/mediarr/torrents/";
    authFile = ./deluge/auth;
  };
}
