{ den, inputs, ... }:
{
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
  };
  den.aspects.apps.provides.web.provides.zen = {
    description = "Zen Browser";
    includes = [ (den._.unfree [ "youtube-recommended-videos" ]) ];

    homeManager = { pkgs, ... }: {
      imports = [ inputs.zen-browser.homeModules.twilight ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        enablePrivateDesktopEntry = true;

        languagePacks = [
          "en-US"
          "pt-BR"
        ];

        nativeMessagingHosts = with pkgs; [ ff2mpv-rust ];
        env = {
          MOZ_USE_XINPUT2 = "1";
          MOZ_DISABLE_RDD_SANDBOX = "1";
          GTK_THEME = "Adwaita";
        };

        policies = {
          AppAutoUpdate = false;
          BackgroundAppUpdate = false;
          DisableProfileImport = true;
          DisableProfileRefresh = true;
          Certificates.ImportEnterpriseRoots = true;
          DisableFirefoxAcounts = true;
          DisableFirefoxStudies = true;
          DisableTelemetry = true;

          DisableMasterPasswordCreation = true;
          DisableAppUpdate = true;
          DisablePocket = true;
          DisableSetDesktopBackground = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          FirefoxHome = {
            Search = true;
            TopSites = true;
            SponsoredTopSites = false; # Fuck you
            Highlights = true;
            Pocket = false;
            SponsoredPocket = false; # Fuck you
            Snippets = false;
            Locked = true;
          };
          FirefoxSuggest = {
            WebSuggestions = true;
            SponsoredSuggestions = false; # Fuck you
            ImproveSuggest = false;
            Locked = true;
          };
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
            EmailTracking = true;
          };
          PasswordManagerEnabled = false;
          GenerativeAI = {
            Enabled = false;
            ChatBot = false;
            LinkPreviews = false;
            TabGroups = false;
            Locked = true;
          };
          ExtensionUpdate = false;
        };

        profiles.default = rec {
          extensions = {
            force = true;
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              localcdn
              darkreader
              ublock-origin
              sponsorblock
              privacy-badger
              clearurls
              fastforwardteam
              return-youtube-dislikes
              consent-o-matic
              ruffle_rs
              indie-wiki-buddy
              violentmonkey
              ff2mpv
              chameleon-ext
              pronoundb
              shinigami-eyes
              bitwarden
              zen-internet
              stylus
              steam-database
              youtube-recommended-videos
            ];
          };
          mods = [
            "72f8f48d-86b9-4487-acea-eb4977b18f21"
            "4a222d82-2803-4ed2-a390-90abfce4f195"
            "906c6915-5677-48ff-9bfc-096a02a72379"
            "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8"
            "79dde383-4fe7-404a-a8e6-9be440022542"
            "cb15abdb-0514-4e09-8ce5-722cf1f4a20f"
            "599a1599-e6ab-4749-ab22-de533860de2c"
            "642854b5-88b4-4c40-b256-e035532109df"
          ];

          presets = {
            betterfox.enable = true;
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

          containersForce = true;
          containers = {
            Personal = {
              color = "purple";
              icon = "fingerprint";
              id = 1;
            };
            Games = {
              color = "green";
              icon = "chill";
              id = 2;
            };
            School = {
              color = "red";
              icon = "briefcase";
              id = 3;
            };
            Shopping = {
              color = "yellow";
              icon = "dollar";
              id = 4;
            };
          };

          spacesForce = true;
          pinsForce = true;
          pinsForceAction = "remove";
          spaces = {
            Personal = {
              id = "264175a8-a507-48b2-bb28-5ca0c2b28125";
              icon = "🏠";
              position = 1000;
              container = containers.Personal.id;

              pins = {
                Whatsapp = {
                  id = "7248cadd-daf4-4f9a-aca2-b24babf4a7ee";
                  url = "https://web.whatsapp.com/";
                  position = 100;
                };
                AsterMail = {
                  id = "349f5fd3-584b-48d3-8b63-7655e0fbf903";
                  url = "https://app.astermail.org/";
                  position = 101;
                };
              };

              routes = {
                youtube1 = {
                  reference = "youtube.com";
                  matchType = "equal-to";
                };
                youtube2 = {
                  reference = "youtu.be";
                  matchType = "equal-to";
                };
                reddit1 = {
                  reference = "reddit.com";
                  matchType = "equal-to";
                };
                reddit2 = {
                  reference = "old.reddit.com";
                  matchType = "equal-to";
                };
                reddit3 = {
                  reference = "new.reddit.com";
                  matchType = "equal-to";
                };
              };
            };
            Games = {
              id = "18a2d818-db7c-4039-83e1-827e87381d78";
              icon = "🎮";
              position = 2000;
              container = containers.Games.id;

              routes = {
                steampowered = {
                  reference = "steampowered.com";
                  matchType = "contains";
                };
                steamcommunity = {
                  reference = "steamcommunity.com";
                  matchType = "contains";
                };
                steamdb = {
                  reference = "steamdb.info";
                  matchType = "equal-to";
                };
              };
            };
            School = {
              id = "0afcebcf-d7c2-4b79-8c10-48d3bec4534d";
              icon = "📕";
              position = 3000;
              container = containers.School.id;
            };
            Shopping = {
              id = "3230acc2-dffc-4a7f-8908-892b68b8bfc4";
              icon = "💸";
              position = 4000;
              container = containers.Shopping.id;
            };
          };
        };
      };
    };
  };
}
