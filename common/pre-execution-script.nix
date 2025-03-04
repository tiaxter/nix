{
  system.activationScripts = {
    # Install Homebrew before nix script execution
    preUserActivation.text = ''
      # HidApiTester executable path
      hidapitesterExecutablePath="/usr/local/bin/hidapitester"

      # Download and install hidapitester
      if ! [[ -f "$hidapitesterExecutablePath" ]]; then
        curl -L https://github.com/todbot/hidapitester/releases/latest/download/hidapitester-macos-arm64.zip | tar -xf - -C .
        sudo mv hidapitester "$hidapitesterExecutablePath"
        sudo chmod +x "$hidapitesterExecutablePath"
      fi

      # Install Catppuccin Frappe Theme on Warp terminal
      if ! [[ -f "$HOME/.warp/themes/catppuccin_frappe.yml" ]]; then
        mkdir -p "$HOME/.warp/themes/"
        curl --output-dir "$HOME/.warp/themes" -LO https://github.com/catppuccin/warp/raw/main/themes/catppuccin_frappe.yml
      fi

      if ! [[ -f "/opt/homebrew/bin/brew" ]] && ! [[ -f "/usr/local/bin/brew" ]]; then
        echo "[+] Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi

      # Install Rosetta
      sudo /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    '';
  };
}
