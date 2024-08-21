{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ./alacritty.nix
    ../shared/home/fish.nix
    #../shared/home/i3.nix
    ../shared/nixvim/nixvim.nix
  ];

  home.username = "wobbat";
  home.homeDirectory = "/home/wobbat";

  # set cursor size and dpi for 4k monitor
 # xresources.properties = {
  #  "Xcursor.size" = 8;
   #  "Xft.dpi" = 172;
  #};

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

   home.file.qtile_config = {
     source = ./qtile/config.py;
     target = ".config/qtile/config.py";
   };

   home.file.awesome_config = {
     source = ./awesome/rc.lua;
     target = ".config/awesome/rc.lua";
   };

    home.file.awesome_theme= {
     source = ./awesome/theme.lua;
     target = ".config/awesome/theme.lua";
   };
  # Packages that should be installed to the user profile.``
  home.packages = with pkgs; [
    eza

    #security
    nmap

    #utils
    file
    which
    btop
    iotop
    iftop
    dmenu
    i3status

    #other
    todoist-electron
    rxvt-unicode
    xorg.xfontsel
  ];

  programs.git = {
    enable = true;
    userName = "wobbat";
    userEmail = "mail@wobbat.com";
  };

  programs.autorandr = {
    enable = true;
  };


  programs.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
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
      # package.disabled = true;
    };
  };

  # This value determines the home Manager release that your
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
