{
  systemd.network.enable = true;
  networking = {
    useDHCP = false;
    nameservers = [
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2606:4700:4700::1111#one.one.one.one"
      "2606:4700:4700::1001#one.one.one.one"
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    dhcpcd.enable = false;
  };
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnssec = "true";
    dnsovertls = "true";
  };
}
