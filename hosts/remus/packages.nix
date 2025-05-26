{ config, pkgs, inputs, ...}: {

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        vscode
        #inputs.helix.packages."${pkgs.system}".helix
        # Removed xorg.xbacklight - use brightnessctl instead for Wayland
        burpsuite
        git
        firefox
        wget
        python3
        jetbrains-mono
        dtrx
        hermit
        # Removed gnomeExtensions.tactile - not needed for Hyprland
        nixfmt-rfc-style
        google-chrome
        # Removed arandr - use Hyprland monitor config instead
        
        # Wayland-specific packages
        wofi              # App launcher for Wayland
        wl-clipboard      # Clipboard utilities for Wayland
        grim              # Screenshot utility for Wayland
        slurp             # Screen area selection for Wayland
        wezterm           # Terminal emulator (as configured in Hyprland)
        swaybg            # Background setter for Wayland
  ];

}
