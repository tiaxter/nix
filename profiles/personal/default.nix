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
    ];
  };

  system.activationScripts.preUserActivation.text = lib.mkAfter ''
    echo "Personal profile"
  '';
}