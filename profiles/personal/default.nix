{ pkgs, lib, self, config, ... }: {
  # Import common configuration
  imports = [
    ../../common
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim neovim ];

  # Install app from homebrew
  homebrew = {
    casks = [
      "orbstack" # Faster Docker replacement
      "ngrok" # Ngrok
      "webstorm" # WebStorm
      "codeedit" # Code editor that mix XCode and VsCode (pre-alpha)
      "mediainfo" # Display video and audio files details
    ];
    brews = [
      "zig" # Zig programming language
      "zls" # Zig LSP
      "deno" # Deno
    ];
  };

  # Add WebStorm icon to the dock
  system.defaults.dock.persistent-apps = [
    "/Applications/WebStorm.app"
  ];

  system.activationScripts.preUserActivation.text = lib.mkAfter ''
    echo "Personal profile"
  '';
}
