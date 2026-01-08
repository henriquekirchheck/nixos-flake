{ pkgs, ... }:
{
  environment.defaultPackages = with pkgs; [
    jmtpfs
    android-tools
  ];
}
