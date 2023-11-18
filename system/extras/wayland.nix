{ config, lib, pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./keyring.nix
              ./fonts.nix
              ./xdg.nix
            ];

  environment.systemPackages = [ pkgs.wayland ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    layout = "br";
    xkbVariant = "";
  };
}

