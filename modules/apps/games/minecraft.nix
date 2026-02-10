{ den, ... }:
{
  den.aspects.apps.provides.games.provides.minecraft = {
    description = "Minecraft";

    provides = {
      launchers.provides.prismlauncher = {
        includes = [ (den._.unfree [ "graalvm-oracle" ]) ];
        homeManager =
          { pkgs, ... }:
          {
            home.packages = [
              (pkgs.prismlauncher.override {
                gamemodeSupport = true;
                jdks = with pkgs; [
                  javaPackages.compiler.temurin-bin.jre-25
                  javaPackages.compiler.temurin-bin.jre-21
                  javaPackages.compiler.temurin-bin.jre-17
                  javaPackages.compiler.temurin-bin.jre-8
                  pkgs.graalvmPackages.graalvm-ce
                  pkgs.graalvmPackages.graalvm-oracle_25
                  pkgs.graalvmPackages.graalvm-oracle_17
                ];
                additionalPrograms = [ pkgs.kdePackages.kdialog ];
              })
            ];
          };
      };

      server.provides.setup-ports.nixos.networking.firewall = {
        allowedTCPPorts = [ 25565 ];
        allowedUDPPorts = [ 25565 ];
      };
    };
  };
}
