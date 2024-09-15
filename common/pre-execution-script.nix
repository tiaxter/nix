{ config, pkgs, lib, ... }:
let 
  cfg = config.modules.preExecutionScript ;
in {
  options.modules.preExecutionScript = {
    homeDirectory = lib.mkOption {
      description = "User home directory path";
      type = lib.types.str;
      default = "";
    };
  };


  config = {
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
        if ! [[ -f "${cfg.homeDirectory}/.warp/themes/catppuccin_frappe.yml" ]]; then
          mkdir -p "${cfg.homeDirectory}/.warp/themes/"
          curl --output-dir "${cfg.homeDirectory}/.warp/themes" -LO https://github.com/catppuccin/warp/raw/main/themes/catppuccin_frappe.yml
        fi

    	  if ! [[ -f "/opt/homebrew/bin/brew" ]] && ! [[ -f "/usr/local/bin/brew" ]]; then
          echo "[+] Installing Homebrew"
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
      '';
    };
  };
}
