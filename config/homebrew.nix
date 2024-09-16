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
      "oven-sh/bun"
      "nikitabobko/tap"
    ];
    casks = [ 
      "warp" # Warp (terminal)
      "aerospace" # Aerospace (tiling window manager)
      "phpstorm" # PHPStorm
      "raycast" # Raycast (spotlight replacement)
      "spotify" # Spotify (music streaming service)
      "arc" # Arc browser
      "iina" # IINA media player
      "lunar" # Lunar (adaptive brightness for external displays)
      "yaak" # Yaak (a lightweight Postman alternative)
      "font-departure-mono" # Pixel font 
      "logi-options+" # Manager for Logitech products
      "karabiner-elements" # Keyboard customiser
      "aerospace"
    ];
    brews = [ 
      "oven-sh/bun/bun" # Bun (best JS engine)
      "zoxide" # Zoxide (cd replacement)
      "helix" # Helix (neovim replacement)
      "nushell" # Nushell (data based shell)
      "direnv" # Direnv (navigate through folders and import .env file automatically)
      "eza" # Colorful ls
    ];
  };
}
