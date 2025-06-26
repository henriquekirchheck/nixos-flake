{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.defaultPackages = with pkgs; [ jmtpfs ];
}
