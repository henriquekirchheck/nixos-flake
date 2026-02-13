{ inputs, ... }:
{
  flake-file.inputs.dms = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      quickshell.follows = "quickshell";
    };
  };

  den.aspects.apps.provides.shell.provides.dms = {
    homeManager =
      { pkgs, lib, ... }:
      {
        imports = [ inputs.dms.homeModules.dank-material-shell ];

        programs.dank-material-shell = {
          enable = true;
          quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

          systemd = {
            enable = true; # Systemd service for auto-start
            restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
          };

          settings = {
            appLauncherGridColumns = 5;
            appsDockActiveColorMode = "primary";
            appsDockColorizeActive = false;
            appsDockEnlargeOnHover = false;
            appsDockEnlargePercentage = 125;
            appsDockHideIndicators = false;
            appsDockIconSizePercentage = 100;
            audioScrollMode = "volume";
            audioVisualizerEnabled = true;
            audioWheelScrollAmount = 5;

            barConfigs = [
              {
                autoHide = false;
                borderEnabled = false;
                bottomGap = -6;
                centerWidgets = [
                  "music"
                  "focusedWindow"
                ];
                clickThrough = true;
                enabled = true;
                fontScale = 1.1;
                gothCornersEnabled = false;
                id = "default";
                innerPadding = 0;
                leftWidgets = [
                    "launcherButton"
                     "systemTray"
                  "workspaceSwitcher"
                ];
                name = "Main Bar";
                noBackground = false;
                openOnOverview = true;
                popupGapsAuto = true;
                popupGapsManual = 4;
                position = 0;
                rightWidgets = [
                  "clipboard"
                  "notificationButton"
                  {
                    enabled = true;
                    id = "cpuUsage";
                    minimumWidth = true;
                  }
                  {
                    enabled = true;
                    id = "memUsage";
                    showSwap = true;
                  }
                  {
                    enabled = true;
                    id = "controlCenterButton";
                    showAudioPercent = true;
                    showBatteryIcon = true;
                    showBrightnessIcon = true;
                    showBrightnessPercent = false;
                    showMicIcon = false;
                    showScreenSharingIcon = true;
                  }
                  "clock"
                ];
                screenPreferences = [ "all" ];
                shadowIntensity = 0;
                showOnLastDisplay = true;
                spacing = 4;
                transparency = lib.mkForce 0;
                visible = true;
                widgetTransparency = lib.mkForce 0.75;
              }
            ];
            barMaxVisibleApps = 0;
            barMaxVisibleRunningApps = 0;
            barShowOverflowBadge = true;
            blurWallpaperOnOverview = false;
            blurredWallpaperLayer = false;
            buttonColorMode = "primary";
            centeringMode = "index";
            clockCompactMode = false;
            clockDateFormat = "yyyy-MM-dd";

            controlCenterShowAudioIcon = true;
            controlCenterShowAudioPercent = false;
            controlCenterShowBatteryIcon = false;
            controlCenterShowBluetoothIcon = true;
            controlCenterShowBrightnessIcon = false;
            controlCenterShowBrightnessPercent = false;
            controlCenterShowMicIcon = false;
            controlCenterShowMicPercent = false;
            controlCenterShowNetworkIcon = true;
            controlCenterShowPrinterIcon = false;
            controlCenterShowScreenSharingIcon = true;
            controlCenterShowVpnIcon = true;
            controlCenterTileColorMode = "primary";
            controlCenterWidgets = [
              {
                enabled = true;
                id = "volumeSlider";
                width = 50;
              }
              {
                enabled = true;
                id = "brightnessSlider";
                width = 50;
              }
              {
                enabled = true;
                id = "wifi";
                width = 50;
              }
              {
                enabled = true;
                id = "bluetooth";
                width = 50;
              }
              {
                enabled = true;
                id = "audioOutput";
                width = 50;
              }
              {
                enabled = true;
                id = "audioInput";
                width = 50;
              }
              {
                enabled = true;
                id = "nightMode";
                width = 50;
              }
              {
                enabled = true;
                id = "darkMode";
                width = 50;
              }
            ];

            dankLauncherV2BorderColor = "primary";
            dankLauncherV2BorderEnabled = false;
            dankLauncherV2BorderThickness = 2;
            dankLauncherV2ShowFooter = true;
            dankLauncherV2Size = "medium";

            dockAutoHide = false;
            dockBorderColor = "surfaceText";
            dockBorderEnabled = false;
            dockBorderOpacity = 1;
            dockBorderThickness = 1;
            dockBottomGap = 0;
            dockGroupByApp = true;
            dockIconSize = 40;
            dockIndicatorStyle = "line";
            dockIsolateDisplays = true;
            dockLauncherEnabled = false;
            dockMargin = 2;
            dockMaxVisibleApps = 0;
            dockMaxVisibleRunningApps = 0;
            dockOpenOnOverview = true;
            dockPosition = 1;
            dockShowOverflowBadge = true;
            dockSpacing = 5;
            dockTransparency = lib.mkForce 0.75;

            enableRippleEffects = true;

            fadeToDpmsEnabled = false;
            fadeToLockEnabled = false;

            groupWorkspaceApps = true;

            launcherLogoColorOverride = "primary";
            launcherLogoMode = "os";

            lockScreenShowDate = true;
            lockScreenShowMediaPlayer = true;
            lockScreenShowPasswordField = true;
            lockScreenShowPowerActions = true;
            lockScreenShowProfileImage = true;
            lockScreenShowSystemIcons = true;
            lockScreenShowTime = true;
            loginctlLockIntegration = true;

            notificationCompactMode = true;
            notificationHistoryEnabled = true;
            notificationHistoryMaxAgeDays = 7;
            notificationHistoryMaxCount = 50;
            notificationHistorySaveCritical = true;
            notificationHistorySaveLow = true;
            notificationHistorySaveNormal = true;
            notificationOverlayEnabled = true;
            notificationPopupPosition = 3;
            notificationTimeoutCritical = 0;
            notificationTimeoutLow = 5000;
            notificationTimeoutNormal = 8000;

            osdAlwaysShowValue = true;
            osdAudioOutputEnabled = true;
            osdBrightnessEnabled = true;
            osdCapsLockEnabled = true;
            osdIdleInhibitorEnabled = true;
            osdMediaPlaybackEnabled = true;
            osdMediaVolumeEnabled = true;
            osdMicMuteEnabled = true;
            osdPosition = 5;
            osdPowerProfileEnabled = false;
            osdVolumeEnabled = true;

            padHours12Hour = true;

            popoutAnimationSpeed = 1;
            popoutCustomAnimationDuration = 150;

            popupTransparency = lib.mkForce 0.75;
            powerActionConfirm = true;
            powerActionHoldDuration = 0.5;
            powerMenuActions = [
              "reboot"
              "logout"
              "poweroff"
              "lock"
              "suspend"
              "restart"
            ];
            powerMenuDefaultAction = "poweroff";

            qtThemingEnabled = false;
            gtkThemingEnabled = false;

            runningAppsCompactMode = true;
            runningAppsCurrentMonitor = false;
            runningAppsCurrentWorkspace = true;
            runningAppsGroupByApp = false;

            scrollTitleEnabled = true;

            showBattery = true;
            showCapsLockIndicator = true;
            showClipboard = true;
            showClock = true;
            showControlCenterButton = true;
            showCpuTemp = true;
            showCpuUsage = true;
            showDock = false;
            showFocusedWindow = true;
            showGpuTemp = true;
            showLauncherButton = true;
            showMemUsage = true;
            showMusic = true;
            showNotificationButton = true;
            showOccupiedWorkspacesOnly = false;
            showOnLastDisplay = {
              notepad = true;
              notifications = true;
            };
            showPrivacyButton = true;
            showSeconds = false;
            showSystemTray = true;
            showWeather = true;
            showWorkspaceApps = false;
            showWorkspaceIndex = false;
            showWorkspaceName = false;
            showWorkspacePadding = false;
            showWorkspaceSwitcher = true;

            soundNewNotification = true;
            soundPluggedIn = true;
            soundVolumeChanged = true;
            soundsEnabled = true;

            spotlightCloseNiriOverview = true;

            systemMonitorColorMode = "primary";

            use24HourClock = false;
            useAutoLocation = false;
            useFahrenheit = false;
            useSystemSoundTheme = false;

            waveProgressEnabled = true;
            weatherEnabled = true;

            workspaceDragReorder = false;
            workspaceFocusedBorderEnabled = false;
            workspaceScrolling = true;
          };

          enableSystemMonitoring = true;
          enableVPN = false;
          enableDynamicTheming = false;
          enableAudioWavelength = true;
          enableCalendarEvents = false;
        };
      };
    provides.niri.homeManager =
      { config, lib, ... }:
      {
        programs.niri.settings.binds =
          let
            dms-ipc = args: {
              spawn = [
                "dms"
                "ipc"
              ]
              ++ args;
            };
          in
          {
            "Mod+Space" = {
              action = dms-ipc [
                "spotlight"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Application Launcher";
            };
            "Mod+N" = {
              action = dms-ipc [
                "notifications"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Notification Center";
            };
            "Mod+Comma" = {
              action = dms-ipc [
                "settings"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Settings";
            };
            "Mod+P" = {
              action = dms-ipc [
                "notepad"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Notepad";
            };
            "Super+Alt+L" = {
              action = dms-ipc [
                "lock"
                "lock"
              ];
              hotkey-overlay.title = "Toggle Lock Screen";
            };
            "Mod+X" = {
              action = dms-ipc [
                "powermenu"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Power Menu";
            };
            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "increment"
                "3"
              ];
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "decrement"
                "3"
              ];
            };
            "XF86AudioMute" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "mute"
              ];
            };
            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "micmute"
              ];
            };
            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action = dms-ipc [
                "brightness"
                "increment"
                "5"
              ];
            };
            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action = dms-ipc [
                "brightness"
                "decrement"
                "5"
              ];
            };
            "Mod+Alt+N" = {
              allow-when-locked = true;
              action = dms-ipc [
                "night"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Night Mode";
            };
            "Mod+V" = {
              action = dms-ipc [
                "clipboard"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Clipboard Manager";
            };
          }
          // lib.attrsets.optionalAttrs config.programs.dank-material-shell.enableSystemMonitoring {
            "Mod+M" = {
              action = dms-ipc [
                "processlist"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Process List";
            };
          };
      };
  };
}
