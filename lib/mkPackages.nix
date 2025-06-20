{ pkgs, inputs ? {}, ... }: {
  # Helper function to create package sets from module imports
  mkPackages = packageModules: 
    let
      # Function to import a package module
      importPackageModule = modulePath:
        import modulePath { inherit pkgs inputs; };
    in
    builtins.concatLists (map importPackageModule packageModules);
  
  # Predefined package profiles for common combinations
  profiles = {
    # Base desktop profile - common packages for desktop systems
    desktop = [
      ../modules/packages/editors.nix
      ../modules/packages/browsers.nix
      ../modules/packages/development.nix
      ../modules/packages/security.nix
      ../modules/packages/cli-tools.nix
      ../modules/packages/media.nix
      ../modules/packages/desktop-utils.nix
      ../modules/packages/wayland.nix
      ../modules/packages/terminal.nix
      ../modules/packages/fonts.nix
    ];
    
    # Minimal profile for basic systems
    minimal = [
      ../modules/packages/cli-tools.nix
      ../modules/packages/terminal.nix
      ../modules/packages/editors.nix
    ];
  };
}