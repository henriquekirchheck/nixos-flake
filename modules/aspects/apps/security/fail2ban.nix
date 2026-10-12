{
  den.aspects.apps.security.fail2ban = {
    nixos.services.fail2ban.enable = true;
    cache = _: { directories = [ "/var/lib/fail2ban" ]; };
  };
}
