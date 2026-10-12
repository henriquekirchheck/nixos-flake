{
  den.aspects.services.sshd = {
    nixos = {
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
    };

    persist = _: {
      files = [
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          how = "symlink";
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          how = "symlink";
          configureParent = true;
        }
      ];
    };

    allow-user = { user, ... }: {
      nixos.services.openssh.settings.AllowUsers = [ user.userName ];
    };
  };
}
