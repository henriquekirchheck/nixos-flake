{ config, lib, pkgs, inputs, ... }:

{
  # Import wayland config
  imports = [ ../extras/wayland.nix
              ../extras/dbus.nix
              ../extras/keyring.nix
              ../extras/fonts.nix
              ../extras/xdg.nix
              ../extras/display-manager.nix
            ];

  # Security
  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
