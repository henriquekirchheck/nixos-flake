{
  den.aspects.services.provides.bitwarden-sync = sopsFile: {
    description = "Bitwarden Sync";
    nixos =
      { config, ... }:
      let
        secret = "bitwarden_sync-env";
      in
      {
        sops.secrets.${secret} = {
          inherit sopsFile;
          format = "dotenv";
        };
        virtualisation.oci-containers.containers."bitwarden-sync" = {
          image = "docker.io/martadams89/bitwarden-sync:latest";
          environment = {
            "CRON_SCHEDULE" = "0 */6 * * *";
          };
          environmentFiles = [
            config.sops.secrets.${secret}.path
          ];
          log-driver = "journald";
          labels."io.containers.autoupdate" = "registry";
        };
      };
  };
}
