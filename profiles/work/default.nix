{ pkgs, lib, self, config, ... }: {
  # Import common configuration
  imports = [
    ../../common
    ./programs/php.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim neovim ];

  # Install app from homebrew
  homebrew = {
    casks = [
      "slack" # Slack (messaging app)
      "phpstorm" # PhpStorm (Best PHP IDE in the world)
    ];
  };

  system.activationScripts.preUserActivation.text = lib.mkAfter ''
    echo "Work profile"
  '';
}