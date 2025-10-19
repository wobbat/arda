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
      ../shared/packages/editors.nix
      ../shared/packages/browsers.nix
      ../shared/packages/development.nix
      ../shared/packages/security.nix
      ../shared/packages/cli-tools.nix
      ../shared/packages/media.nix
      ../shared/packages/desktop-utils.nix
      ../shared/packages/wayland.nix
      ../shared/packages/terminal.nix
      ../shared/packages/fonts.nix
    ];
    
    # Minimal profile for basic systems
    minimal = [
      ../shared/packages/cli-tools.nix
      ../shared/packages/terminal.nix
      ../shared/packages/editors.nix
    ];
  };
}