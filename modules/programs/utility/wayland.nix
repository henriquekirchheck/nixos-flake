{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    dragon-drop
  ];
}
