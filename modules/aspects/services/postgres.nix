{ den, ... }:
{
  den.aspects.services.postgres = {
    nixos.services.postgresql = {
      enable = true;
      enableJIT = true;
    };
    persist = _: { directories = [ "/var/lib/postgresql" ]; };
  };

  den.quirks.postgresDBBackup.description = "PostgreSQL databases to backup";

  den.aspects.services.postgres.backup = {
    includes = [ den.aspects.services.postgres.backup.collect ];
    nixos.services.postgresqlBackup = {
      enable = true;
      compression = "zstd";
      compressionLevel = 19;
    };
    cache = _: { directories = [ "/var/backup/postgresql" ]; };
  };

  den.aspects.services.postgres.backup.collect = {
    nixos = { postgresDBBackup, ... }: {
      services.postgresqlBackup.databases = postgresDBBackup;
    };
  };
}
