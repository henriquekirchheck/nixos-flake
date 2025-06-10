{ pkgs }:
{
  isNormalUser = true;
  description = "Henrique Kirch Heck";
  extraGroups = [
    "networkmanager"
    "wheel"
    "docker"
    "podman"
    "libvirtd"
    "kvm"
    "adbusers"
  ];
  initialPassword = "changeme";
  shell = pkgs.zsh;
}
