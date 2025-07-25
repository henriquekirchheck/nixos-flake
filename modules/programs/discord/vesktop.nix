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
          AlwaysExpandRoles.enabled = true;
          BadgeAPI.enabled = true;
          BetterFolders.enabled = true;
          BetterGifPicker.enabled = true;
          BetterRoleContext.enabled = true;
          BetterSettings.enabled = true;
          BiggerStreamPreview.enabled = true;
          CallTimer.enabled = true;
          ClearURLs.enabled = true;
          CommandsAPI.enabled = true;
          CopyFileContents.enabled = true;
          CopyUserURLs.enabled = true;
          CrashHandler.enabled = true;
          DevCompanion.enabled = true;
          DisableCallIdle.enabled = true;
          DisableDeepLinks.enabled = true;
          Experiments.enabled = true;
          ExpressionCloner.enabled = true;
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
          ForceOwnerCrown.enabled = true;
          FriendsSince.enabled = true;
          FullSearchContext.enabled = true;
          GameActivityToggle.enabled = true;
          GifPaste.enabled = true;
          GreetStickerPicker.enabled = true;
          ImageZoom.enabled = true;
          ImplicitRelationships.enabled = true;
          InvisibleChat.enabled = true;
          MemberCount.enabled = true;
          MessageAccessoriesAPI.enabled = true;
          MessageEventsAPI.enabled = true;
          MessageLatency.enabled = true;
          MessageLinkEmbeds.enabled = true;
          MessageLogger.enabled = true;
          NoDevtoolsWarning.enabled = true;
          NoOnboardingDelay.enabled = true;
          NoUnblockToJump.enabled = true;
          NoTrack = {
            disableAnalytics = true;
            enabled = true;
          };
          PermissionFreeWill.enabled = true;
          PermissionsViewer.enabled = true;
          PinDMs.enabled = true;
          PlatformIndicators.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          RelationshipNotifier.enabled = true;
          ReplaceGoogleSearch.enabled = true;
          RevealAllSpoilers.enabled = true;
          ReverseImageSearch.enabled = true;
          ServerInfo.enabled = true;
          ServerListIndicators.enabled = true;
          Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
          };
          ShowHiddenChannels.enabled = true;
          ShowHiddenThings.enabled = true;
          SilentMessageToggle.enabled = true;
          ShikiCodeblocks.enabled = true;
          SpotifyCrack.enabled = true;
          SupportHelper.enabled = true;
          StickerPaste.enabled = true;
          Translate.enabled = true;
          TypingIndicator.enabled = true;
          TypingTweaks.enabled = true;
          UserMessagesPronouns = {
            enabled = true;
            pronounsFormat = "LOWERCASE";
            showSelf = true;
          };
          UserVoiceShow.enabled = true;
          UserSettingsAPI.enabled = true;
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          ViewRaw.enabled = true;
          VoiceDownload.enabled = true;
          VoiceMessages = {
            echoCancellation = false;
            enabled = true;
            noiseSuppression = false;
          };
          VolumeBooster.enabled = true;
          WebContextMenus.enabled = true;
          WebKeybinds.enabled = true;
          "WebRichPresence (arRPC)".enabled = false;
          WebScreenShareFixes.enabled = true;
          WhoReacted.enabled = true;
          XSOverlay.enabled = false;
          YoutubeAdblock.enabled = true;
          petpet.enabled = true;
        };
      };
    };
  };
}
