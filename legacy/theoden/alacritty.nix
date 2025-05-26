{
  programs.alacritty = {
    enable = true;
    # shell = pkgs.fish;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 14;
        normal = {
          family = "Inconsolata";
          style = "Bold";
        };
      };
      shell = "fish";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window = {
        padding.x = 20;
        padding.y = 20;
        decorations = "buttonless";
      };

      # colors = {
      #   # Default colors
      #   primary = {
      #     background = "#151515";
      #     foreground = "#b4b4b4";
      #   };

      #   # Normal colors
      #   normal = {
      #     black = "#151515";
      #     red = "#7e4a3e";
      #     green = "#65763e";
      #     yellow = "#ab8652";
      #     blue = "#8297b3";
      #     magenta = "#77526f";
      #     cyan = "#5f7a71";
      #     white = "0xcbe3e7";
      #   };

      #   # # Bright colors
      #   # bright = {
      #   #   black = "#151515";
      #   #   red = "#ab8652";
      #   #   green = "0x62d196";
      #   #   yellow = "0xffb378";
      #   #   blue = "0x65b2ff";
      #   #   magenta = "0x906cff";
      #   #   cyan = "0x63f2f1";
      #   #   white = "#b4b4b4";
      #   # };
      # };
    };
  };
}


# local colors = {
#     none = "NONE",
#     fg = "#b4b4b4",
#     bg = "#151515",
#     alt_bg = "#171717",
#     accent = "#202020",
#     white = "#b4b4b4",
#     gray = "#2c2c2c",
#     medium_gray = "#5b5b5b",
#     light_gray = "#8c8c8c",
#     blue = "#8297b3",
#     gray_blue = "#7e4a3e",
#     medium_gray_blue = "#717f87",
#     cyan = "#5f7a71",
#     -- red = "#7e4a3e",
#     green = "#65763e",
#     red = "#ab8652",
#     yellow = "#ab8652",
#     orange = "#b3733d",
#     purple = "#77516f",
#     magenta = "#77526f",
#     cursor_fg = "#151515",
#     cursor_bg = "#a6a6a6",
#     sign_add = "#546533",
#     sign_change = "#4b5e71",
#     sign_delete = "#8d4332",
#     error = "#7a3a2b",
#     warning = "#896a40",
#     info = "#b3733d",
#     -- info = "#896a40",
#     hint = "#465968",
#     accent_blue = "#191a20",
#     accent_green = "#1c2019",
#     accent_red = "#201919",
# }
