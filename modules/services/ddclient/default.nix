{
  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    domains = [ "henriquekh.dev.br" ];
    zone = "henriquekh.dev.br";
    username = "token";
  };
}
