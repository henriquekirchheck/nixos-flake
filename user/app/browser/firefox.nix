{ config, lib, pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
  };
  home.sessionVariables = { DEFAULT_BROWSER = "${config.programs.firefox.package}/bin/firefox-nightly"; };
  home.packages = [
    (pkgs.writeScriptBin "firefox" ''exec firefox-nightly $@'')
  ];
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
}
