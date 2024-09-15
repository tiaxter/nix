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
    homeDirectory = "/Users/${username}";
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
          # Set 'disable sleep when power adapter attached with closed lid'
          sudo pmset disablesleep 1

          # HidApiTester executable path
          hidapitesterExecutablePath="/usr/local/bin/hidapitester"

          # Download and install hidapitester
          if ! [[ -f "$hidapitesterExecutablePath" ]]; then
            curl -L https://github.com/todbot/hidapitester/releases/latest/download/hidapitester-macos-arm64.zip | tar -xf - -C . 
            sudo mv hidapitester "$hidapitesterExecutablePath"
            sudo chmod +x "$hidapitesterExecutablePath"
          fi
        
          # Install Catppuccin Frappe Theme on Warp terminal
          if ! [[ -f "${homeDirectory}/.warp/themes/catppuccin_frappe.yml" ]]; then
            mkdir -p "${homeDirectory}/.warp/themes/"
            curl --output-dir "${homeDirectory}/.warp/themes" -LO https://github.com/catppuccin/warp/raw/main/themes/catppuccin_frappe.yml
          fi

      	  if ! [[ -f "/opt/homebrew/bin/brew" ]] && ! [[ -f "/usr/local/bin/brew" ]]; then
            echo "[+] Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          fi
        '';
      };

      imports = [ 
        ./common/homebrew.nix 
        ./common/mac-os-settings.nix
        ./common/home-manager.nix
      ];

      modules.macOsSettings.homeDirectory = "${homeDirectory}";
      modules.homeManager = {
        username = "${username}";
        homeDirectory = "${homeDirectory}";
        git = {
          username = "${username}";
          email = "${email}";
        };
      };

      # Users settings (TODO avoid hardcoding username)
      users.users."${username}" = {
        name = "${username}";
        home = "${homeDirectory}";
      };

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
