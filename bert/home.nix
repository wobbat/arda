{ config, pkgs, inputs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./home/hyprland.nix
      ./home/fish.nix
      ./starship.nix
    ];

  home.username = "wobbat";
  home.homeDirectory = "/home/wobbat";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
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
    #other
    discord
    signal-desktop
    nixfmt-unstable
  ];

  programs.git = {
    enable = true;
    userName = "wobbat";
    userEmail = "wobbat@proton.me";
  };






  # starship - an customizable prompt for any shell
#   programs.starship = {
#     enable = true;
#     # custom settings
#     settings = {
#       add_newline = false;
#       aws.disabled = true;
#       gcloud.disabled = true;
#       line_break.disabled = true;
#     };
#   };

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
        style  = "Bold";
        };
      };
      shell = "fish";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };



#   programs.bash = {
#     enable = true;
#     enableCompletion = true;
#     # TODO add your custom bashrc here
#     bashrcExtra = ''
#       export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
#     '';

#     # set some aliases, feel free to add more or remove some
#     shellAliases = {
#       k = "kubectl";
#       urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
#       urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
#     };
#   };

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
