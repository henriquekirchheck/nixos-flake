{ pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.cosmic-greeter}/bin/cosmic-greeter; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    startplasma-wayland
    Hyprland
    zsh
  '';
}
