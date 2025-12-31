_:

{
  programs.chromium = {
    enable = true;
    extraOpts = {
      "ExtensionManifestV2Availability" = 2;
    };
  };
}
