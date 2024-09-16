{ config, pkgs, lib, ... }: {
  # Set Mac OS settings
  system.defaults = {
    dock = {
      tilesize = 45; # Set dock icon size
      autohide = true; # Set dock auto hide behaviour
      show-recents = false; # Hide recent used application in the dock
      mru-spaces = false; # Disable workspace rearrangement based on used apps
      expose-group-by-app = true; # Workaround for Aerospace and Mission Control

      # Disable hot corners functionality
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;

      # Set pinned apps on the dock
      persistent-apps = [
        "/Applications/Arc.app"
        "/Applications/Warp.app"
        "/Applications/PhpStorm.app"
        "/Applications/Spotify.app"
      ];
    };

    NSGlobalDomain = {
      # Remove Mac keyboard input delay
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      ApplePressAndHoldEnabled = false;

      AppleShowAllExtensions = true; # Show file extensions in Finder
      AppleShowAllFiles = true; # Show hidden files in Finder
      NSTableViewDefaultSizeMode = 1; # Set small icon size in Finder sidebar

      NSNavPanelExpandedStateForSaveMode = true; # Expand save panel by default
      NSDocumentSaveNewDocumentsToCloud = false; # Save to disk (not to iCloud) by default
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false; # Disable click wallpaper to reveal desktop
    };

    finder = {
      FXDefaultSearchScope = "SCcf"; # Search in the current folder by default
      FXPreferredViewStyle = "Nlsv"; # Set default file view to list
      ShowPathbar = true; # Show path bar
    };

    menuExtraClock = {
      Show24Hour = true; # Show time using 24 hours format
      ShowDate = 1; # Show always the date
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = true;
    };

    screencapture = {
      type = "png"; # Set screenshot image type to png
    };

    screensaver = {
      askForPassword = true; # Ask password after screensaver
      askForPasswordDelay = 0; # The number of seconds to delay before the password will be required to unlock or stop the screen saver
    };

    CustomSystemPreferences = {
      # Disable cmd-space for native spotlight
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "64" = {
            enabled = false;
          };
        };
      };
    };

    CustomUserPreferences = {
      # Disable dictation on double 'cltr' press
      "com.apple.HIToolbox" = {
        AppleFnUsageType = 0;
      };

      # Show battery percentage in top menu bar
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true;
      };

      # Set screenshot location to 'clipboard'
      "com.apple.screencapture" = {
        target = "clipboard";
      };

      # Set Arc browser different icon
      "company.thebrowser.Browser" = {
        currentAppIconName = "colorful";
      };

      # Set Warp theme
      "dev.warp.Warp-Stable" = {
        Theme = builtins.toJSON {
          Custom = {
            name = "Catppuccin Frappe";
            path = "${config.modules.homeManager.homeDirectory}/.warp/themes/catppuccin_frappe.yml";
          };
        };
        FontName = builtins.toJSON "Departure Mono";
        FontSize = builtins.toJSON "13.0";
      };
    };
  };

  # Enable sudo authentication with Touch ID.
  security.pam.enableSudoTouchIdAuth = true;
}
