{ pkgs, ... }:

{
  home.packages = [
    (pkgs.prismlauncher.override {
      gamemodeSupport = true;
      jdks = [
        pkgs.jdk21
        pkgs.jdk17
        pkgs.jdk8
        pkgs.graalvm-ce
      ];
      additionalPrograms = [ pkgs.kdePackages.kdialog ];
    })
  ];
}
