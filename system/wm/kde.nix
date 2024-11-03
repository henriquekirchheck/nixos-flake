{
  config,
  pkgs,
  lib,
  ...
}:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'O que você quer fazer?' \
      -b 'Desligar' 'systemctl poweroff' \
      -b 'Reiniciar' 'systemctl reboot'
  '';
in
{
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  programs.dconf.enable = true;

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
    khelpcenter
    konsole
  ];

  services.greetd = {
    enable = false;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
    startplasma-wayland
    bash
    zsh
  '';
}
