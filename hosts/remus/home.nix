{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../../modules/home/hyprland.nix
    ../../modules/home/wezterm.nix
    ../../modules/home/fish.nix
    ../../modules/home/helix.nix
  ];

  home.username = "wobbat";
  home.homeDirectory = "/home/wobbat";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  # Packages that should be installed to the user profile.``
  home.packages = with pkgs; [
    eza

    #security
    nmap

    #utils
  ];

  programs.git = {
    enable = true;
    userName = "wobbat";
    userEmail = "mail@wobbat.com";
  };

  programs.autorandr = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=WaylandWindowDecorations"
        "--force-device-scale-factor=1.5"
      ];
    };
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      format = ''
        $time $directory
        $character
      '';
      right_format = ''$all'';

      # add_newline = false;

      character = {
        success_symbol = "[|](bold red)[|](bold green)[|](bold yellow)[|](bold purple)[|](bold blue)";
        error_symbol = "[|](bold red)[|](bold red)[|](bold red)[|](bold red)[|](bold red)";
      };

      aws = {
        disabled = true;
      };

      time = {
        disabled = false;
        format = "[$time](white bold)";
        time_format = "%H:%M";
      };

      directory = {
        style = "white bold";
      };
    };
  };

  # legacy dots
  home.file.".config/rofi".source = ../../modules/.files/rofi;
  home.file.".config/rofi".recursive = true;

  home.file.".config/nvim".source = ../../modules/.files/nvim;
  home.file.".config/nvim".recursive = true;

  # This value determines the home Manager release that your2
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
