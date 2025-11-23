{ inputs, config, ... }:

{
  imports = [inputs.niri-caelestia-shell.homeManagerModules.default];
  
  programs.caelestia = {
    enable = true;
    systemd.enable = true;
    settings.path.wallpaperDir = "${config.xdg.userDirs.pictures}/wallpapers";
  };
}
