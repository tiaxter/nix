{
  # Enable homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    taps = [
      "nikitabobko/tap"
    ];
    casks = [ 
      "warp" # Warp (terminal)
      "aerospace" # Aerospace (tiling window manager)
      "raycast" # Raycast (spotlight replacement)
      "arc" # Arc browser
      "iina" # IINA media player
      "lunar" # Lunar (adaptive brightness for external displays)
      "yaak" # Yaak (a lightweight Postman alternative)
      "font-departure-mono" # Pixel font 
      "logi-options+" # Manager for Logitech products
      "karabiner-elements" # Keyboard customiser
      "whatsapp" # Native Whatsapp Client
    ];
    brews = [ 
      "zoxide" # Zoxide (cd replacement)
      "helix" # Helix (neovim replacement)
      "nushell" # Nushell (data based shell)
      "direnv" # Direnv (navigate through folders and import .env file automatically)
      "eza" # Colorful ls
      "mise" # Runtime manager for various programs like NodeJS, Bun, PHP and others
    ];
  };
}
