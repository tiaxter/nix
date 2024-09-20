{
  # Enable zoxide.nix and configure it
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    options = [ "--cmd cd" ]; # use "cd" alias
  };
}