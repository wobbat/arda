{ config, pkgs, inputs, ...}: {

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        vscode
        inputs.helix.packages."${pkgs.system}".helix
        burpsuite
        git
        firefox
        wget
        python3
        jetbrains-mono
        dtrx
        hermit
        cbmc
        cmake
        gcc-arm-embedded-9
        doxygen
        gnumake
        dotnetCorePackages.dotnet_8.sdk
        python312Packages.intelhex
        gnomeExtensions.tactile
        nixfmt-rfc-style
        google-chrome
  ];

}