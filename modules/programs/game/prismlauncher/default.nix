{ pkgs, ... }:

{
  home.packages = [
    (pkgs.prismlauncher.override {
      gamemodeSupport = true;
      jdks = [
        pkgs.jdk21
        pkgs.jdk17
        pkgs.jdk8
        pkgs.graalvmPackages.graalvm-ce
      ];
      additionalPrograms = [ pkgs.kdePackages.kdialog ];
    })
  ];
}
