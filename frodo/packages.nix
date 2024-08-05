{ config, pkgs, inputs, ...}: {

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        vscode
        #inputs.helix.packages."${pkgs.system}".helix
        burpsuite
        git
        firefox
        wget
        python3
        jetbrains-mono
        dtrx
        hermit
        gnomeExtensions.tactile
        nixfmt-rfc-style
        google-chrome
        arandr
  ];

}
