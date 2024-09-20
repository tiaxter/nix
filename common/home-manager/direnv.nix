{ config, pkgs, lib, ... }:
let
  cfg = config.modules.direnv;
in {
  options.modules.direnv = {
    whitelistPrefix = lib.mkOption {
      description = "Whitelist prefix";
      type = lib.types.str;
      default = "";
    };
  };

  config = {
    # Enable direnv and configure it
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      # Load .env file automatically without looking for a .envrc file
      config = {
        global = {
          load_dotenv = true;
        };
        whitelist = {
          prefix = [ "${cfg.whitelistPrefix}" ];
        };
      };
    };
  };
}