{
  pkgs,
  config,
  ...
}:

{
  imports = [
    ../../modules/system/bootloader/systemd-boot.nix
    ../../modules/system/kernel/xanmod.nix
    ../../modules/system/networking/network-manager.nix
    ../../modules/system/firewall
    ../../modules/system/audio/pipewire.nix
    ../../modules/system/pro-audio
    ../../modules/system/virtualisation/containers/podman.nix
    ../../modules/system/virtualisation/hypervisors/qemu.nix
    ../../modules/system/permission/doas.nix
    ../../modules/system/dynamic-linking
    ../../modules/system/nix

    ../../modules/services/ssh/openssh.nix
    ../../modules/services/caddy
    ../../modules/services/ddclient
    ../../modules/services/cloudflared
    ../../modules/services/zerotier
    ../../modules/services/syncthing

    ../../modules/games/steam

    ../../modules/programs/obs
    ../../modules/programs/shell/zsh
    ../../modules/programs/utilities/cli.nix
    ../../modules/programs/utilities/sound.nix
    ../../modules/programs/utilities/wayland.nix

    ../../modules/hardware/android
    ../../modules/hardware/gpu/nvidia.nix

    ../../modules/wm/niri

    ../../modules/styles/fonts

    ../../containers/bitwarden
    ../../containers/searxng
    ../../containers/media
    ../../containers/copyparty

    ../../modules/cache/nixos.nix
  ];

  # System Specific
  networking.hostName = "henrique-pc";
  time.timeZone = "America/Sao_Paulo";
  console.keyMap = "br-abnt2";
  i18n =
    let
      extraLocale = "pt_BR.UTF-8";
      defaultLocale = "en_US.UTF-8";
    in
    {
      inherit defaultLocale;
      extraLocaleSettings = {
        LC_ADDRESS = extraLocale;
        LC_IDENTIFICATION = extraLocale;
        LC_MEASUREMENT = extraLocale;
        LC_MONETARY = extraLocale;
        LC_NAME = extraLocale;
        LC_NUMERIC = extraLocale;
        LC_PAPER = extraLocale;
        LC_TELEPHONE = extraLocale;
        LC_TIME = extraLocale;
      };
    };
  system.stateVersion = "25.05";

  ## Sops
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age = {
      sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  ## Cloudflare Tunnels
  sops.secrets."tunnel-52ba507f-2e7c-4527-9010-aaa4ff579fa2" = {
    sopsFile = ./secrets/52ba507f-2e7c-4527-9010-aaa4ff579fa2.json;
    format = "json";
    key = "";
  };
  services.cloudflared.tunnels = {
    "52ba507f-2e7c-4527-9010-aaa4ff579fa2" = {
      credentialsFile = "${config.sops.secrets."tunnel-52ba507f-2e7c-4527-9010-aaa4ff579fa2".path}";
      ingress = {
        "jelly.henriquekh.dev.br" = "http://localhost:8096";
        "vault.henriquekh.dev.br" = "http://localhost:8179";
        "search.henriquekh.dev.br" = "http://localhost:5947";
        "files.henriquekh.dev.br" = "http://localhost:3923";
        "app.tunnel.henriquekh.dev.br" = "http://localhost:3000";
      };
      default = "http_status:404";
    };
  };

  ## Caddy
  sops.secrets.caddy_env = {
    sopsFile = ./secrets/caddy.env;
    format = "dotenv";
    key = "";
    owner = config.services.caddy.user;
  };
  systemd.services.caddy.serviceConfig.EnvironmentFile = [ "${config.sops.secrets.caddy_env.path}" ];

  ## ddclient
  sops.secrets.ddclient = {
    sopsFile = ./secrets/ddclient.json;
    format = "json";
    key = "password";
  };
  services.ddclient.passwordFile = config.sops.secrets.ddclient.path;

  ## syncthing
  sops.secrets.syncthing-key = {
    sopsFile = ./secrets/syncthing/key.pem;
    format = "binary";
  };
  sops.secrets.syncthing-cert = {
    sopsFile = ./secrets/syncthing/cert.pem;
    format = "binary";
  };

  services.syncthing = {
    key = config.sops.secrets.syncthing-key.path;
    cert = config.sops.secrets.syncthing-cert.path;
    settings = {
      folders."/home/henrique/org/".devices = [ "henrique-laptop" ];
      devices = {
        "henrique-laptop" = {
	  addresses = [
	    "tcp://192.168.192.70:22000"
	    "dynamic"
	  ];
          name = "Laptop";
          id = "XOTEBRB-4CF7OS3-SK326Z2-ZNUW72H-GWC2LNU-ANXLSFM-2SWPVTK-OF7YIA7";
        };
      };
    };
  };

  ## Network configuration
  systemd.network = {
    networks = {
      "10-enp0s31f6" = {
        matchConfig.Name = "enp0s31f6";
        networkConfig = {
          DHCP = "ipv6";
          Address = "10.0.0.10/24";
          Gateway = "10.0.0.1";

          IPv6AcceptRA = "yes";
          LinkLocalAddressing = "ipv6";

          DNS = [
            "2620:fe::fe"
            "2620:fe::9"
            "2606:4700:4700::1111"
            "2606:4700:4700::1001"
            "9.9.9.9"
            "149.112.112.112"
            "1.1.1.1"
            "1.0.0.1"
          ];
          DNSSEC = "allow-downgrade";
          DNSOverTLS = "yes";
        };

        dhcpV4Config = {
          UseHostname = "no";
          UseDNS = "no";
          UseNTP = "no";
          UseSIP = "no";
          UseRoutes = "no";
          UseGateway = "yes";
        };

        ipv6AcceptRAConfig = {
          UseDNS = "no";
          DHCPv6Client = "yes";
        };

        dhcpV6Config = {
          WithoutRA = "solicit";
          UseDelegatedPrefix = true;
          UseHostname = "no";
          UseDNS = "no";
          UseNTP = "no";
        };

        linkConfig.RequiredForOnline = "routable";
      };
    };
  };
}
