{ config, pkgs, lib, ... }:
let
  cfg = config.modules.git;
in {
  options.modules.git = {
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

  config = {
    # Set git data
    programs.git = {
      enable = true;
      settings.user = {
        name  = cfg.username;
        email = cfg.email;
      };
    };
  };
}