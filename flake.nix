{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # Nix-darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    username = "tiaxter";
    email = "jerrytiapalmiotto@gmail.com";
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [ vim neovim ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      system.activationScripts = {
        # Install Homebrew before nix script execution
        preUserActivation.text = ''
          # Install Catppuccin Frappe Theme on Warp terminal
          if ! [[ -f "/Users/${username}/.warp/themes/catppuccin_frappe.yml" ]]; then
            mkdir -p ~/.warp/themes/
            curl --output-dir /Users/${username}/.warp/themes -LO https://github.com/catppuccin/warp/raw/main/themes/catppuccin_frappe.yml
          fi

      	  if ! [[ -f "/opt/homebrew/bin/brew" ]] && ! [[ -f "/usr/local/bin/brew" ]]; then
            echo "[+] Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          fi
    	  '';
      };

      # Enable homebrew
      homebrew = {
        enable = true;

      	taps = [ "oven-sh/bun" ];
      	casks = [ 
    	    "warp" # Warp (terminal)
    	    "nikitabobko/tap/aerospace" # Aerospace (tiling window manager)
    	    "phpstorm" # PHPStorm
    	    "raycast" # Raycast (spotlight replacement)
    	    "spotify" # Spotify (music streaming service)
    	    "arc" # Arc browser
    	    "iina" # IINA media player
    	    "lunar" # Lunar (adaptive brightness for external displays)
    	    "yaak" # Yaak (a lightweight Postman alternative)
          "font-departure-mono" # Pixel font 
      	];
      	brews = [ 
    	    "oven-sh/bun/bun" # Bun (best JS engine)
    	    "zoxide" # Zoxide (cd replacement)
    	    "helix" # Helix (neovim replacement)
          "nushell" # Nushell (data based shell)
          "direnv" # Direnv (navigate through folders and import .env file automatically)
      	];
      };

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
  	      location = "clipboard"; # Copy screenshotted image to the clipboard
  	      type = "png"; # Set screenshot image type to png
    	  };

    	  screensaver = {
  	      askForPassword = true; # Ask password after screensaver
  	      askForPasswordDelay = 0; # The number of seconds to delay before the password will be required to unlock or stop the screen saver
    	  };

    	  CustomUserPreferences = {
          # Set Arc browser different icon
  	      "company.thebrowser.Browser" = {
            currentAppIconName = "colorful";
  	      };

          # Set Warp theme
          "dev.warp.Warp-Stable" = {
            Theme = builtins.toJSON {
              Custom = {
                name = "Catppuccin Frappe";
                path = "/Users/${username}/.warp/themes/catppuccin_frappe.yml";
              };
            };
            FontName = builtins.toJSON "Departure Mono";
            FontSize = builtins.toJSON "13.0";
          };
    	  };
      };

      # Users settings (TODO avoid hardcoding username)
      users.users."${username}" = {
        name = "${username}";
        home = "/Users/${username}";
      };

      # Home-manager settings
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${username}" = {
          # TODO: capire a che cazzo serve
          home.stateVersion = "23.05";

          programs = {
            # Let Home Manager install and manage itself.
            home-manager.enable = true;
            
            # Enable zsh
            zsh = {
              enable = true;
            };

            # Enable fish shell
            fish = {
              enable = true;
            };

            # Enable nushell
            nushell = {
              enable = true;
            };

            # Enable zoxide and configure it
            zoxide = {
              enable = true;
              enableFishIntegration = true;
              enableZshIntegration = true;
              enableNushellIntegration = true;
              options = [ "--cmd cd" ]; # use "cd" alias
            };

            # Enable direnv and configure it
            direnv = {
              enable = true;
              # enableFishIntegration = true;
              enableZshIntegration = true;
              enableNushellIntegration = true;
              # Load .env file automatically without looking for a .envrc file
              config = {
                global = {
                  load_dotenv = true;
                };
                whitelist = {
                  prefix = [ "/Users/${username}" ];
                };
              };
            };

            # Set git data
            git = {
              enable = true;
              userName  = "${username}";
              userEmail = "${email}";
            };
          };
        };
      };

      # Enable sudo authentication with Touch ID.
      security.pam.enableSudoTouchIdAuth = true;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
      modules = [ 
        home-manager.darwinModules.home-manager
        configuration
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
