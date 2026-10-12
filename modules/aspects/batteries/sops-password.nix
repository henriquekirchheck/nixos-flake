{ __findFile, ... }: {
  den.aspects.batteries.sops-password = {
    include = [ <sops> ];
    nixos = { config, user, ... }: {
      sops.secrets."${user.userName}/password" = {
        key = "password";
        sopsFile = config.home-manager.users.${user.userName}.sops.defaultSopsFile;
        neededForUsers = true;
      };
    };
    user = { config, user, ... }: {
      hashedPasswordFile = config.sops.secrets."${user.userName}/password".path;
    };
  };
}
