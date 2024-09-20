{ config, pkgs, lib, ...}: 
let 
    cfg = config.modules.homeManager;
in {
  # Params
  options.modules.homeManager = {
    host = {
      username = lib.mkOption {
        description = "Username used on the host";
        type = lib.types.str;
        default = "";
      };

      home = lib.mkOption {
        description = "Home directory path used on the host";
        type = lib.types.str;
        default = "";
      };
    };

    git = {
      username = lib.mkOption {
        description = "Username used in Git";
        type = lib.types.str;
        default = "";
      };
      email = lib.mkOption {
        description = "Email used in Git";
        type = lib.types.str;
        default = "";
      };
    };
  };

  config = {
    # Home-manager settings
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users."${cfg.host.username}" = {
        home.stateVersion = "23.05";

        imports = [
          ./zoxide.nix
          ./direnv.nix
          ./git.nix
          ./mise.nix
        ];

        # Set imported modules args
        modules.direnv.whitelistPrefix = "${cfg.host.home}";
        modules.git = cfg.git;

        programs = {
          # Let Home Manager install and manage itself.
          home-manager.enable = true;

          # Enable zsh
          zsh.enable = true;

          # Enable fish shell
          fish.enable = true;

          # Enable nushell
          nushell.enable = true;

          eza = {
            enable = true;
            git = true;
            icons = true;
          };
        };

        # Karabiner configuration
        xdg.configFile.karabiner = {
          enable = true;
          source = ./karabiner/karabiner.json;
          target = "/.config/karabiner/karabiner.json";
          recursive = true;
        };

        # Aerospace configuration
        xdg.configFile.aerospace.source = ./aerospace;

        # Helix configuration
        xdg.configFile.helix.source = ./helix;

        # IdeaVIM configuration
        home.file.".ideavimrc".source = ./ideavim/.ideavimrc;
      };
    };
  };
}
