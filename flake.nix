{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Lix (Nix replacement)
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, lix-module, nixpkgs, home-manager }:
  let
    username = "tiaxter";
    email = "jerrytiapalmiotto@gmail.com";
    homeDirectory = "/Users/${username}";

    # Modules args
    args = {
      modules.homeManager = {
        # Home and user data
        host = {
          username = "${username}";
          home = "${homeDirectory}";
        };

        # Git data
        git = {
          username = "${username}";
          email = "${email}";
        };
      };

      # Users settings
      users.users."${username}" = {
        name = "${username}";
        home = "${homeDirectory}";
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };
  in
  {

    # Build darwin flake using:
    # $ nix run nix-darwin -- switch --flake .#personal
    darwinConfigurations."personal" = nix-darwin.lib.darwinSystem {
      modules = [ 
        lix-module.nixosModules.default
        home-manager.darwinModules.home-manager
        ./profiles/personal
        args
      ];
    };

    # $ nix run nix-darwin -- switch --flake .#work
    darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
      modules = [
        lix-module.nixosModules.default
        home-manager.darwinModules.home-manager
        ./profiles/work
        args
      ];
    };
  };
}
