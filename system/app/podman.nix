{
  pkgs,
  username,
  ...
}:

{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
    dockerSocket.enable = true;
    autoPrune.enable = true;
  };
  users.users.${username}.extraGroups = [ "podman" ];
  environment.systemPackages = [pkgs.podman-compose pkgs.podman-desktop];
}
