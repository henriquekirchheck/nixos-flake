{
  pkgs,
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

    ../../modules/services/ssh/openssh.nix
    ../../modules/services/zerotier

    ../../modules/games/steam

    ../../modules/programs/obs
    ../../modules/programs/shell/zsh
    ../../modules/programs/browsers/chromium
    ../../modules/programs/utilities/cli.nix
    ../../modules/programs/utilities/sound.nix
    ../../modules/programs/utilities/wayland.nix

    ../../modules/hardware/android
    ../../modules/hardware/bluetooth
    ../../modules/hardware/gpu/amdgpu.nix

    ../../modules/wm/hyprland
    ../../modules/wm/kde
    ../../modules/dm/sddm

    ../../modules/styles/fonts

    ../../modules/cachix/henriquekh
    ../../modules/cachix/hyprland
    ../../modules/cachix/nix-community
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

  ## Nix Config
  nix = {
    package = pkgs.lix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
      "repl-flake"
    ];
  };
}
