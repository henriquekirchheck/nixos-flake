{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../hardware/sound.nix
    ./dbus.nix
    ./keyring.nix
    ./fonts.nix
    ./xdg.nix
  ];

  environment.systemPackages = [ pkgs.wayland ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "br";
      variant = "";
    };
  };
}
