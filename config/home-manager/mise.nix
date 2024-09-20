{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        node = [ "latest" ];
        bun = [ "latest" ];
      };
      settings = {
        experimental = true;
      };
    };
  };
}