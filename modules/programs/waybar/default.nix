{ lib, osConfig, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
        "modules-left" = [
          "custom/launcher"
          "tray"
          "hyprland/workspaces"
        ];
        "modules-center" = [ "hyprland/window" ];
        "modules-right" = [
          (lib.mkIf (osConfig.networking.hostName == "henrique-pc") "cpu")
          (lib.mkIf (osConfig.networking.hostName == "henrique-pc") "memory")
          (lib.mkIf (osConfig.networking.hostName == "henrique-laptop") "backlight")
          (lib.mkIf (osConfig.networking.hostName == "henrique-laptop") "battery")
          "pulseaudio"
          "clock"
        ];
        "pulseaudio" = {
          "tooltip" = false;
          "scroll-step" = if (osConfig.networking.hostName == "henrique-laptop") then 1 else 5;
          "format" = "{icon} {volume}%";
          "format-muted" = "{icon} {volume}%";
          "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "on-click" = "activate";
          "format-icons" = {
            "1" = "󰆍";
            "2" = "";
            "3" = "󰉋";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "󰌢";
            "8" = "󰙯";
            "9" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };
        "backlight" = {
          "tooltip" = false;
          "format" = " {}%";
          "interval" = 1;
          "on-scroll-up" = "brightnessctl --min-value=1 set +1%";
          "on-scroll-down" = "brightnessctl --min-value=1 set 1%-";
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "  {icon}  {capacity}%";
          "format-discharging" = "{icon}  {capacity}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          "tooltip" = true;
        };
        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };
        "clock" = {
          "format" = " {0:%H:%M}  󰃶 {0:%d/%m/%Y}";
        };
        "cpu" = {
          "interval" = 10;
          "format" = " {usage}%";
          "max-length" = 10;
        };
        "memory" = {
          "interval" = 10;
          "format" = " {used} GiB";
          "max-length" = 10;
        };
        "custom/launcher" = {
          "format" = "󱄅 ";
          "on-click" = "rofi -show drun";
          "on-click-right" = "killall rofi";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12px;
        min-height: 10px;
      }

      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #window {
        margin-top: 6px;
        padding-left: 10px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        font-weight: bold;
        background: rgba(22, 19, 32, 0.4);
      }

      window#waybar.empty #window {
        color: transparent;
        background: transparent;
      }

      #workspaces {
        margin-top: 6px;
        margin-left: 12px;
        font-size: 4px;
        margin-bottom: 0px;
        border-radius: 10px;
        background: #161320;
        transition: none;
      }

      #workspaces button {
        transition: none;
        color: #b5e8e0;
        background: transparent;
        font-size: 16px;
        border-radius: 2px;
      }

      #workspaces button.occupied {
        transition: none;
        color: #f28fad;
        background: transparent;
        font-size: 4px;
      }

      #workspaces button.active {
        color: #abe9b3;
        border-bottom: 2px solid #abe9b3;
        border-radius: 4px;
      }

      #workspaces button:hover {
        transition: none;
        box-shadow: inherit;
        text-shadow: inherit;
        color: #fae3b0;
        border-color: #e8a2af;
        color: #e8a2af;
      }

      #workspaces button.focused:hover {
        color: #e8a2af;
      }

      #network {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #161320;
        background: #bd93f9;
      }

      #pulseaudio {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1a1826;
        background: #fae3b0;
      }

      #clock {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #161320;
        background: #abe9b3;
        /*background: #1A1826;*/
      }

      #memory {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #161320;
        background: #ddb6f2;
      }

      #backlight {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #161320;
        background: #ddb6f2;
      }

      @keyframes blink-warning {
        from {
          color: white;
          background-color: black;
        }

        70% {
          color: white;
          background-color: black;
        }

        to {
          color: white;
          background-color: #d08770;
        }
      }

      @keyframes blink-critical {
        from {
          color: white;
          background-color: black;
        }

        70% {
          color: white;
          background-color: black;
        }

        to {
          color: white;
          background-color: #bf616a;
        }
      }

      #battery {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #161320;
        background: #96cdfb;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.warning {
        color: #d08770;
      }

      #battery.critical {
        color: #bf616a;
      }

      #battery.warning.discharging {
        animation-name: blink-warning;
        animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #cpu {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #161320;
        background: #96cdfb;
      }

      #tray {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #b5e8e0;
        background: #161320;
      }

      #custom-launcher {
        font-size: 16px;
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 5px;
        border-radius: 10px;
        transition: none;
        color: #89dceb;
        background: #161320;
      }
    '';
  };
}
