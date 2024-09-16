{ config, pkgs, lib, ...}: 
let 
  cfg = config.modules.homeManager;
in {
  # Params
  options.modules.homeManager = {
    username = lib.mkOption {
      description = "Username used on the host";
      type = lib.types.str;
      default = "";
    };

    homeDirectory = lib.mkOption {
      description = "Home directory path used on the host";
      type = lib.types.str;
      default = "";
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
      users."${cfg.username}" = {
        home.stateVersion = "23.05";

        programs = {
          # Let Home Manager install and manage itself.
          home-manager.enable = true;
      
          # Enable zsh
          zsh = {
            enable = true;
          };

          # Enable fish shell
          fish = {
            enable = true;
          };

          # Enable nushell
          nushell = {
            enable = true;
          };

          # Enable zoxide and configure it
          zoxide = {
            enable = true;
            enableFishIntegration = true;
            enableZshIntegration = true;
            enableNushellIntegration = true;
            options = [ "--cmd cd" ]; # use "cd" alias
          };

          # Enable direnv and configure it
          direnv = {
            enable = true;
            # enableFishIntegration = true;
            enableZshIntegration = true;
            enableNushellIntegration = true;
            # Load .env file automatically without looking for a .envrc file
            config = {
              global = {
                load_dotenv = true;
              };
              whitelist = {
                prefix = [ "${cfg.homeDirectory}" ];
              };
            };
          };

          eza = {
            enable = true;
            git = true;
            icons = true;
          };

          # Set git data
          git = {
            enable = true;
            userName  = "${cfg.git.username}";
            userEmail = "${cfg.git.email}";
          };

        };

        # Karabiner configuration
        xdg.configFile.karabiner = {
          enable = true;
          source = ../karabiner/karabiner.json;
          target = "/.config/karabiner/karabiner.json";
          recursive = true;
        };

        # Aerospace configuration
        xdg.configFile.aerospace.source = ../aerospace;

        # Helix configuration
        xdg.configFile.helix.source = ../helix;
      };
    };
  };
}
