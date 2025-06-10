{
  networking.useDHCP = false;
  systemd.network.enable = true;
  networking.dhcpcd.enable = false;
}