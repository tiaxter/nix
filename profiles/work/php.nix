{ config, ... }:
let
  username = config.modules.homeManager.host.username;
  # Set PHP versions to install
  phpVersions = [ "8.1" "8.3" ];
  # Generate shell aliases
  aliases = builtins.listToAttrs (map((version: rec {
      name = ("php" + builtins.replaceStrings [ "." ] [ "" ] version);
      value = "/opt/homebrew/opt/php@" + version + "/bin/php";
    })
  ) phpVersions);
in {
  # Install php versions using homebrew
  homebrew.brews = map(version: "php@" + version) phpVersions;

  # Set shells aliases
  home-manager.users."${username}".programs = {
    zsh.shellAliases = aliases;
    fish.shellAliases = aliases;
  };
}