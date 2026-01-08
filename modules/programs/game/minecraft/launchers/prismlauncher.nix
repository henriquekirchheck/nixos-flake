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
        pkgs.graalvmPackages.graalvm-oracle
        pkgs.graalvmPackages.graalvm-oracle_17
      ];
      additionalPrograms = [ pkgs.kdePackages.kdialog ];
    })
  ];
}
