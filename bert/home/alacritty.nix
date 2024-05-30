{
  programs.alacritty = {
    enable = true;
    # shell = pkgs.fish;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 16;
        normal = {
          family = "Jetbrains Mono";
          style = "Bold";
        };
      };
      shell = "fish";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
