{config, pkgs, ...}: {
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
      "logi-options-plus" # Manager for Logitech products
      "karabiner-elements" # Keyboard customiser
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
