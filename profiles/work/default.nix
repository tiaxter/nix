{ pkgs, lib, self, config, ... }: {
  # Import common configuration
  imports = [
    ../base.nix
    ./php.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim neovim ];

  # Install app from homebrew
  homebrew = {
    casks = [
      "slack" # Slack (messaging app)
    ];
  };

  system.activationScripts.preUserActivation.text = lib.mkAfter ''
    echo "Work profile"
  '';
}