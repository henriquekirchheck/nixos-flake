{ den, ... }:
{
  den.aspects.apps.provides.window-managers.provides.hyprland = {
    includes = [ den.aspects.apps._.wayland ];
    description = "Hyprland";
    nixos = {
      programs.hyprland = {
        enable = true;
      };
    };
  };
}
