{ self, config, system, ... }: {
  imports = [
    ./pre-execution-script.nix
    ./homebrew.nix
    ./mac-os-settings.nix
    ./home-manager
  ];

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "root" "tiaxter" ];
    # extra-substituters = [
    #   "https://exo.cachix.org"
    #   "https://cache.nixos-cuda.org"
    # ];
    # extra-trusted-public-keys = [
    #   "exo.cachix.org-1:LA-CHIAVE-VERA="
    #   "cache.nixos-cuda.org-1:LA-CHIAVE-VERA="
    # ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Primary user for user-scoped system options.
  system.primaryUser = "tiaxter";

  # Match the actual nixbld group GID on this system.
  ids.gids.nixbld = 350;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # mdbook-linkcheck was removed from nixpkgs; alias it to the replacement.
  nixpkgs.overlays = [
    (final: prev: {
      mdbook-linkcheck = prev.mdbook-linkcheck2;
    })
  ];
}
