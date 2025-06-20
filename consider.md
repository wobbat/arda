# Future Restructure Plan (Option B)

## Overview
Complete architectural restructure to profiles-based system for maximum maintainability and zero duplication.

## Target Architecture

### Directory Structure
```
.
├── flake.nix                 # Minimal, data-driven
├── lib/
│   ├── mkSystem.nix         # System builder function
│   ├── mkProfile.nix        # Profile composition logic
│   └── utils.nix            # Helper utilities
├── profiles/
│   ├── base.nix             # Common to all systems
│   ├── desktop.nix          # Desktop environment base
│   ├── development.nix      # Development tools
│   ├── gaming.nix           # Gaming setup
│   └── server.nix           # Server configuration
├── hosts/
│   ├── hugin.nix            # Host-specific attributes only
│   ├── remus.nix
│   ├── fawkes.nix
│   └── solo.nix
├── hardware/                # Pure hardware configs
│   ├── hugin.nix
│   ├── remus.nix
│   └── fawkes.nix
└── modules/                 # Feature modules
    ├── desktop/
    ├── development/
    └── system/
```

### Host Definition Pattern
```nix
# hosts/hugin.nix
{
  # System info
  hostname = "hugin";
  system = "x86_64-linux";
  stateVersion = "25.05";
  
  # Profile composition
  profiles = [ "base" "desktop" "development" ];
  
  # Desktop environment
  desktop = {
    enable = true;
    environment = "hyprland";
    scale = 1.5;
  };
  
  # Hardware
  hardware = ./hardware/hugin.nix;
  
  # Host-specific overrides
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  # User configuration
  users.primary = {
    name = "wobbat";
    description = "stan";
    shell = "fish";
    homeManager = ./home/hugin.nix;
  };
}
```

### Flake Transformation
```nix
# flake.nix (after restructure)
{
  outputs = { nixpkgs, ... }@inputs: 
  let
    mkSystem = import ./lib/mkSystem.nix { inherit inputs; };
    hosts = {
      hugin = import ./hosts/hugin.nix;
      remus = import ./hosts/remus.nix;
      fawkes = import ./hosts/fawkes.nix;
      solo = import ./hosts/solo.nix;
    };
  in {
    nixosConfigurations = builtins.mapAttrs (_: mkSystem) 
      (lib.filterAttrs (_: host: host.type or "nixos" == "nixos") hosts);
    
    homeConfigurations = builtins.mapAttrs (_: mkHome)
      (lib.filterAttrs (_: host: host.type or "nixos" == "home-manager") hosts);
  };
}
```

## Implementation Phases

### Phase 1: Profile System
- Create `profiles/` directory with base profile
- Implement `lib/mkProfile.nix` for profile composition
- Convert one host (hugin) to use profiles
- Test and verify functionality

### Phase 2: Host Abstraction
- Create `lib/mkSystem.nix` system builder
- Convert all hosts to attribute-based definitions
- Simplify flake.nix to use builders
- Extract hardware configs to `hardware/`

### Phase 3: Module Reorganization
- Restructure `modules/` by feature area
- Implement conditional module loading based on host attributes
- Create desktop environment abstraction layer
- Unify home-manager integration

### Phase 4: Advanced Features
- Implement profile inheritance system
- Add environment-specific configuration (work/home/test)
- Create automated host generation for common patterns
- Add configuration validation and testing

## Benefits After Restructure

### Code Reduction
- flake.nix: ~100 lines → ~30 lines
- Host configs: ~150 lines each → ~20 lines each
- Total codebase: ~70-80% reduction

### Maintenance Improvements
- New host: 5 minutes vs 30 minutes
- System updates: Single profile change affects all relevant hosts
- Configuration drift: Impossible due to shared profiles
- Testing: Easy to create test variants of any host

### Advanced Capabilities
- Multiple environment support (work/home configs)
- Conditional feature enabling based on host type
- Automated security baseline enforcement
- Easy backup/disaster recovery through declarative configs

## Prerequisites for Implementation
- Solid understanding of NixOS module system
- Familiarity with Nix language advanced features (recursion, map/filter)
- Backup of current working configuration
- Time for thorough testing (2-3 weeks recommended)

## Migration Strategy
1. Implement alongside current system (parallel structure)
2. Convert one host at a time
3. Run both systems during transition period
4. Remove old structure only after full validation
5. Document new patterns and usage

## Estimated Effort
- Planning: 1-2 days
- Implementation: 1-2 weeks  
- Testing & refinement: 1 week
- Documentation: 2-3 days

Total: 3-4 weeks for complete restructure