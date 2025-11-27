{ config, ... }:

{
  sops.secrets.syncthing-password = {
    format = "yaml";
    sopsFile = ../../../secrets.yaml;
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "henrique";
    guiPasswordFile = config.sops.secrets.syncthing-password.path;
    settings = {
      gui.theme = "black";
      folders = {
        "/home/henrique/org/" = {
          id = "org";
          label = "Emacs Org";
          devices = [ "henrique-phone" ];
        };
      };
      devices = {
        henrique-phone = {
          name = "Phone";
          id = "OO6XGLP-7J5PXGX-LRMTFSU-HRN4PZV-DKCGMRF-4YT5MHT-EG2RGPL-UDC5YQW";
        };
      };
      options = {
        relaysEnabled = true;
      };
    };
  };
}
