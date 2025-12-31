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
    ../../modules/system/virtualisation/containers/podman.nix
    ../../modules/system/virtualisation/hypervisors/qemu.nix
    ../../modules/system/permission/doas.nix
    ../../modules/system/dynamic-linking
    ../../modules/system/nix

    ../../modules/services/ssh/openssh.nix
    ../../modules/services/zerotier
    ../../modules/services/syncthing

    ../../modules/programs/game/steam

    ../../modules/programs/media/video/obs
    ../../modules/programs/shell/zsh
    ../../modules/programs/web/chromium
    ../../modules/programs/utility/cli.nix
    ../../modules/programs/utility/sound.nix
    ../../modules/programs/utility/wayland.nix

    ../../modules/hardware/android
    ../../modules/hardware/printing
    ../../modules/hardware/bluetooth
    ../../modules/hardware/gpu/amdgpu.nix

    ../../modules/wm/niri
    ../../modules/wm/kde
    ../../modules/dm/cosmic-greeter

    ../../modules/styles/fonts

    ../../modules/cache/nixos.nix
  ];

  # System Specific
  networking.hostName = "henrique-laptop";
  time.timeZone = "America/Sao_Paulo";
  console.keyMap = "br-abnt2";
  i18n =
    let
      extraLocale = "pt_BR.UTF-8";
      defaultLocale = "pt_BR.UTF-8";
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
  systemd.user.services.niri-flake-polkit.enable = false;

  ## Hardware Video Acceleration
  hardware.graphics = {
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.intel-vaapi-driver
    ];
    extraPackages32 = [ pkgs.pkgsi686Linux.intel-vaapi-driver ];
  };

  ## Sops
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

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
      folders."/home/henrique/org/".devices = [ "henrique-pc" ];
      devices = {
        "henrique-pc" = {
          addresses = [
            "tcp://192.168.192.69:22000"
            "dynamic"
          ];
          name = "PC";
          id = "4IC6S6I-CSQYWOU-RKPYC6R-5IXWDIV-ZNT2354-2FAE555-JFRTHAA-SXXB7QT";
        };
      };
    };
  };
}
