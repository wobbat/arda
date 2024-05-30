{ config, pkgs, inputs, ...}: {

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        vscode
        inputs.helix.packages."${pkgs.system}".helix
        # inputs.wbp.packages."${pkgs.system}".burppro
        burpsuite
        git
        firefox
        wget
        python3
        jetbrains-mono
        rustscan
  ];

}