{ pkgs, ... }:
let
  catppuccinOptions = {
    accents = [ "sapphire" ];
    flavour = [ "mocha" ];
  };
  catppuccinName = "catppuccin-${builtins.elemAt catppuccinOptions.flavour 0}-${builtins.elemAt catppuccinOptions.accents 0}";
  catppuccinTheme = pkgs.catppuccin-discord.override catppuccinOptions;
in
{
  programs.vesktop = {
    enable = true;

    settings = {
      appBadge = false;
      arRPC = true;
      customTitleBar = false;
      hardwareAcceleration = true;
      discordBranch = "canary";
      minimizeToTray = true;
      tray = true;
      spellCheckLanguages = [
        "en-US"
        "en"
        "pt-BR"
      ];
      splashColor = "rgb(219, 220, 223)";
      splashBackground = "rgb(12, 12, 14)";
    };

    vencord = {
      themes.${catppuccinName} = "${catppuccinTheme}/share/${catppuccinName}.css";
      useSystem = true;
      settings = {
        enabledThemes = [
          "${catppuccinTheme}/share/${catppuccinName}.css"
        ];
        autoUpdate = false;
        autoUpdateNotification = false;
        enableReactDevtools = true;
        plugins = {
          BadgeAPI.enabled = true;
          BetterFolders.enabled = true;
          BetterGifPicker = {
            enabled = false;
          };
          BiggerStreamPreview.enabled = true;
          CallTimer.enabled = true;
          CommandsAPI.enabled = true;
          CrashHandler.enabled = true;
          DisableCallIdle.enabled = true;
          DisableDeepLinks.enabled = true;
          Experiments.enabled = true;
          FakeNitro = {
            enabled = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
            enableStreamQualityBypass = true;
            transformCompoundSentence = false;
            transformEmojis = true;
            transformStickers = true;
          };
          FixCodeblockGap.enabled = true;
          FixImagesQuality.enabled = true;
          FixSpotifyEmbeds.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          FriendsSince.enabled = true;
          FullSearchContext.enabled = true;
          GameActivityToggle.enabled = true;
          ImageZoom.enabled = true;
          MemberCount.enabled = true;
          MessageAccessoriesAPI.enabled = true;
          MessageEventsAPI.enabled = true;
          MessageLatency.enabled = true;
          NoDevtoolsWarning.enabled = true;
          NoTrack = {
            disableAnalytics = true;
            enabled = true;
          };
          PlatformIndicators.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          ReverseImageSearch.enabled = true;
          Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
          };
          ShikiCodeblocks.enabled = true;
          SpotifyCrack.enabled = true;
          SupportHelper.enabled = true;
          Translate.enabled = true;
          TypingIndicator = {
            enabled = false;
          };
          UserMessagesPronouns = {
            enabled = true;
            pronounsFormat = "LOWERCASE";
            showSelf = true;
          };
          UserSettingsAPI.enabled = true;
          VoiceMessages = {
            echoCancellation = false;
            enabled = true;
            noiseSuppression = false;
          };
          WebContextMenus.enabled = true;
          WebKeybinds.enabled = true;
          "WebRichPresence (arRPC)" = {
            enabled = false;
          };
          WebScreenShareFixes.enabled = true;
          WhoReacted.enabled = true;
          XSOverlay = {
            enabled = false;
          };
          YoutubeAdblock.enabled = true;
          petpet.enabled = true;
        };
      };
    };
  };
}
