{ lib, ... }: {
  system.activationScripts = {
    postActivation.text = lib.mkBefore ''
      # HidApiTester executable path
      hidapitesterExecutablePath="/usr/local/bin/hidapitester"

      # Download and install hidapitester
      if ! [[ -f "$hidapitesterExecutablePath" ]]; then
        curl -L https://github.com/todbot/hidapitester/releases/latest/download/hidapitester-macos-arm64.zip | tar -xf - -C /tmp
        mv /tmp/hidapitester "$hidapitesterExecutablePath"
        chmod +x "$hidapitesterExecutablePath"
      fi

      # Install Catppuccin Frappe Theme on Warp terminal
      if ! [[ -f "/Users/tiaxter/.warp/themes/catppuccin_frappe.yml" ]]; then
        sudo -u tiaxter mkdir -p "/Users/tiaxter/.warp/themes/"
        sudo -u tiaxter curl --output-dir "/Users/tiaxter/.warp/themes" -LO https://github.com/catppuccin/warp/raw/main/themes/catppuccin_frappe.yml
      fi

      if ! [[ -f "/opt/homebrew/bin/brew" ]] && ! [[ -f "/usr/local/bin/brew" ]]; then
        echo "[+] Installing Homebrew"
        sudo -u tiaxter /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi

      # Install Rosetta
      /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    '';
  };
}
