{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "pt-BR"
    ];
    policies = {
      Certificates.ImportEnterpriseRoots = true;
      DisableFirefoxAcounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
    };
    profiles.user = {
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          decentraleyes
          ublock-origin
          sponsorblock
          privacy-badger
          clearurls
          fastforwardteam
          return-youtube-dislikes
          consent-o-matic
          stylus
          ruffle_rs
          indie-wiki-buddy
          violentmonkey
          steam-database
          pronoundb
          shinigami-eyes
          bitwarden
          iina-open-in-mpv
          firefox-color
        ];
      };
      settings = {
        force = true;
        "general.autoScroll" = true;
        "browser.link.open_newwindow" = 3;
        "browser.tabs.hoverPreview.showThumbnails" = true;
        "sidebar.verticalTabs" = false;
        "sidebar.revamp" = true;
        "media.eme.enabled" = true;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "signon.rememberSignons" = false;
        "extensions.autoDisableScopes" = 14;

        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "media.av1.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.preferences.experimental.hidden" = false;
      };
      search = {
        force = true;
        default = "SearXNG";
        privateDefault = "SearXNG";
        engines = {
          "SearXNG" = {
            urls = [
              {
                template = "https://search.henriquekh.dev.br/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "https://search.henriquekh.dev.br/static/themes/simple/img/favicon.png";
            definedAliases = [
              "@sxng"
              "@search"
              "@xng"
            ];
          };
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };
        };
      };
    };
  };
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };
}
