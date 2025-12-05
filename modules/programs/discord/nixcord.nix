{ inputs, pkgs, ... }:

let
  catppuccinOptions = {
    accents = [ "sapphire" ];
    flavour = [ "mocha" ];
  };
  catppuccinName = "catppuccin-${builtins.elemAt catppuccinOptions.flavour 0}-${builtins.elemAt catppuccinOptions.accents 0}";
  catppuccinTheme = pkgs.catppuccin-discord.override catppuccinOptions;
in
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord = {
      enable = true;
      branch = "canary";
    };
    vesktop = {
      enable = true;
      useSystemVencord = false;
    };
    dorion = {
      enable = true;
      desktopNotifications = true;
      streamerModeDetection = true;
      sysTray = true;
      updateNotify = false;
      rpcServer = true;
    };
    openASAR.enable = true;
    config = {
      enableReactDevtools = true;
      frameless = true;
      transparent = true;
      themes = {
        ${catppuccinName} = ${catppuccinTheme}/share/${catppuccinName}.theme.css;
      };
      enabledThemes = [ "${catppuccinName}.css" ];
      plugins = {
        usrbg.enable = true;
        alwaysAnimate.enable = true;
        alwaysExpandRoles.enable = true;
        betterFolders.enable = true;
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterRoleContext.enable = true;
        betterRoleDot.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        biggerStreamPreview.enable = true;
        callTimer.enable = true;
        clearUrLs.enable = true;
        copyFileContents.enable = true;
        disableCallIdle.enable = true;
        experiments = {
          enable = true;
          toolbarDevMenu = true;
        };
        expressionCloner.enable = true;
        fakeNitro = {
          enable = true;
          transformCompoundSentence = true;
        };
        favoriteEmojiFirst.enable = true;
        favoriteGifSearch.enable = true;
        fixCodeblockGap.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        fullUserInChatbox.enable = true;
        gameActivityToggle.enable = true;
        gifPaste.enable = true;
        greetStickerPicker.enable = true;
        imageFilename.enable = true;
        imageZoom = {
          enable = true;
          nearestNeighbour = true;
        };
        implicitRelationships.enable = true;
        invisibleChat.enable = true;
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageLatency.enable = true;
        messageLinkEmbeds.enable = true;
        messageLogger.enable = true;
        mutualGroupDMs.enable = true;
        noDevtoolsWarning.enable = true;
        noF1.enable = true;
        noOnboardingDelay.enable = true;
        noPendingCount = {
          enable = true;
          hideFriendRequestsCount = false;
          hidePremiumOffersCount = true;
        };
        noUnblockToJump.enable = true;
        normalizeMessageLinks.enable = true;
        permissionFreeWill.enable = true;
        permissionsViewer.enable = true;
        petpet.enable = true;
        pinDMs.enable = true;
        platformIndicators.enable = true;
        previewMessage.enable = true;
        reactErrorDecoder.enable = true;
        readAllNotificationsButton.enable = true;
        reverseImageSearch.enable = true;
        roleColorEverywhere.enable = true;
        sendTimestamps.enable = true;
        serverInfo.enable = true;
        shikiCodeblocks = {
          enable = true;
          useDevIcon = "COLOR";
        };
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        silentMessageToggle.enable = true;
        spotifyCrack.enable = true;
        startupTimings.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        userMessagesPronouns.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        viewIcons.enable = true;
        viewRaw.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        webScreenShareFixes.enable = true;
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
}
