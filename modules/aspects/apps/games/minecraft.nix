{ __findFile, ... }:
{
  den.aspects.apps.games.minecraft = {
    launchers.prismlauncher = {
      includes = [ (<den/unfree> [ "graalvm-oracle" ]) ];
      homeManager = { pkgs, ... }: {
        home.packages = [
          (pkgs.prismlauncher.override {
            gamemodeSupport = true;
            jdks = with pkgs; [
              javaPackages.compiler.temurin-bin.jre-26
              javaPackages.compiler.temurin-bin.jre-25
              javaPackages.compiler.temurin-bin.jre-21
              javaPackages.compiler.temurin-bin.jre-17
              javaPackages.compiler.temurin-bin.jre-8
              pkgs.graalvmPackages.graalvm-ce
              pkgs.graalvmPackages.graalvm-oracle_25
            ];
            additionalPrograms = [ pkgs.kdePackages.kdialog ];
          })
        ];
      };

      persistHome = _: {
        directories = [ ".local/share/PrismLauncher" ];
      };
    };
    server.ports = {
      nixos.networking.firewall = {
        allowedTCPPorts = [
          25565
          24454
        ];
        allowedUDPPorts = [
          25565
          24454
        ];
      };
    };
  };
}
