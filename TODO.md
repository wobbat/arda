# NixOS Configuration Refactor - Option A Implementation Plan

## Overview
Conservative modularization approach to eliminate duplication while preserving current structure and approach.

## Current Issues to Address
1. **flake.nix duplication**: Nearly identical nixosConfigurations blocks
2. **Host main.nix duplication**: ~90% identical code across hugin/remus/fawkes
3. **Package management repetition**: Manual imports in packages.nix files
4. **Path inconsistencies**: solo uses ../shared/ while others use ../../modules/
5. **Home manager duplication**: Identical home-manager setup blocks

## Implementation Plan

### Phase 1: Create Helper Functions
**Goal**: Eliminate flake.nix duplication through helper functions

#### Step 1.1: Create lib directory and mkSystem helper
- [ ] Create `lib/` directory
- [ ] Create `lib/mkSystem.nix` with function to generate nixosSystem configurations
- [ ] Include automatic home-manager integration in helper
- [ ] Function should accept: hostname, system, specialArgs, modules, home-modules

#### Step 1.2: Update flake.nix to use helper
- [ ] Import helper function in flake.nix
- [ ] Replace all nixosConfigurations with single helper calls
- [ ] Maintain existing functionality while reducing duplication
- [ ] Test each host builds correctly

**Expected Result**: flake.nix reduces from ~110 lines to ~40 lines

### Phase 2: Extract Common System Configuration
**Goal**: Create shared system module to eliminate host main.nix duplication

#### Step 2.1: Create shared system module
- [ ] Create `modules/system/` directory
- [ ] Create `modules/system/common.nix` with all shared configuration:
  - Basic system settings (allowUnfree, stateVersion base)
  - Nix settings (gc, optimise, experimental-features)
  - Common boot settings (systemd-boot config limit)
  - Networking base (networkmanager.enable)
  - Bluetooth configuration
  - Localization (timezone, locale settings)
  - Audio (pipewire configuration)  
  - Security (polkit, rtkit)
  - Flatpak setup
  - Base user configuration structure

#### Step 2.2: Create desktop environment module
- [ ] Create `modules/system/desktop.nix` for desktop-specific config:
  - Hyprland/Wayland setup
  - X11 keyboard configuration
  - Environment variables
  - XDG portal configuration

#### Step 2.3: Create desktop profiles
- [ ] Create `modules/system/profiles/hyprland.nix` for Hyprland desktop
- [ ] Create `modules/system/profiles/awesome.nix` for AwesomeWM + X11 setup
- [ ] Each profile contains desktop-specific configuration

#### Step 2.4: Update host configurations
- [ ] Update `hosts/hugin/main.nix` to import common + hyprland profile
- [ ] Update `hosts/remus/main.nix` to import common + hyprland profile + vmware host
- [ ] Update `hosts/fawkes/main.nix` to import common + awesome profile + vmware guest
- [ ] Each host should only contain:
  - Hardware import
  - Package import  
  - Hostname
  - Host-specific overrides (bootloader, vmware, etc.)

**Expected Result**: Host main.nix files reduce from ~170 lines to ~30 lines each

### Phase 3: Simplify Package Management
**Goal**: Streamline package imports and organization

#### Step 3.1: Create package management helper
- [ ] Create `lib/mkPackages.nix` helper function
- [ ] Function takes list of package module names and returns combined list
- [ ] Add optional host-specific package overrides parameter

#### Step 3.2: Update package organization
- [ ] Review and consolidate package modules in `modules/packages/`
- [ ] Ensure consistent naming and structure
- [ ] Consider creating package profiles (base, desktop, development, etc.)

#### Step 3.3: Update host package.nix files
- [ ] Replace manual imports with helper function calls
- [ ] Use package profiles where appropriate
- [ ] Maintain host-specific package customization ability

**Expected Result**: Package files reduce from ~19 lines to ~5 lines each

### Phase 4: Standardize Home Manager Integration
**Goal**: Eliminate home manager duplication and inconsistencies

#### Step 4.1: Create home manager helper
- [ ] Create `lib/mkHome.nix` helper for home-manager configuration
- [ ] Include standard home-manager settings (useGlobalPkgs, useUserPackages)
- [ ] Support for home module imports and user-specific overrides

#### Step 4.2: Standardize home configurations
- [ ] Create base home configuration template
- [ ] Standardize common home settings (cursor, stateVersion, etc.)
- [ ] Extract repeated home.file configurations to shared modules

#### Step 4.3: Fix path inconsistencies
- [ ] Update `hosts/solo/home.nix` to use `../../modules/` paths consistently
- [ ] Remove `../shared/` references and migrate to standard module structure
- [ ] Ensure all hosts use consistent module paths

### Phase 5: Clean Up and Optimize
**Goal**: Final cleanup and optimization

#### Step 5.1: Remove duplicated configurations
- [ ] Clean up any remaining duplicate configuration blocks
- [ ] Consolidate similar settings across hosts
- [ ] Remove unused imports and files

#### Step 5.2: Standardize module structure
- [ ] Ensure consistent module organization
- [ ] Clean up `.files` directory organization
- [ ] Standardize module naming conventions

#### Step 5.3: Add configuration validation
- [ ] Add basic configuration validation where possible
- [ ] Ensure all hosts build successfully
- [ ] Test switching between configurations

## Testing Strategy
- [ ] Test each phase incrementally
- [ ] Verify all hosts build: `nix flake check`
- [ ] Test each host builds and switches successfully
- [ ] Verify home-manager configurations work correctly
- [ ] Test rebuilding from scratch

## Success Metrics
- **Code Reduction**: Target 60-70% reduction in total configuration size
- **Duplication Elimination**: No more than 5-10% duplicate code remaining
- **Consistency**: All hosts use identical patterns and helpers
- **Maintainability**: Adding new host requires <5 file changes
- **Functionality**: All existing functionality preserved

## Directory Structure After Refactor
```
.
├── flake.nix                    # Simplified with helpers (~40 lines)
├── lib/
│   ├── mkSystem.nix            # NixOS system builder
│   ├── mkHome.nix              # Home manager helper  
│   └── mkPackages.nix          # Package management helper
├── hosts/
│   ├── hugin/
│   │   ├── main.nix            # Minimal host config (~30 lines)
│   │   ├── home.nix            # Standardized home config
│   │   ├── hardware.nix        # Hardware-specific only
│   │   └── packages.nix        # Package selection (~5 lines)
│   ├── remus/                  # Same structure
│   ├── fawkes/                 # Same structure  
│   └── solo/                   # Consistent paths
├── modules/
│   ├── system/
│   │   ├── common.nix          # Shared system configuration
│   │   ├── desktop.nix         # Desktop environment base
│   │   └── profiles/
│   │       ├── hyprland.nix    # Hyprland profile
│   │       └── awesome.nix     # AwesomeWM profile
│   ├── home/                   # Home manager modules
│   ├── packages/               # Package collections
│   └── .files/                 # Configuration files
```

## Implementation Timeline
- **Phase 1**: 1-2 days
- **Phase 2**: 2-3 days  
- **Phase 3**: 1 day
- **Phase 4**: 1-2 days
- **Phase 5**: 1 day
- **Testing**: 1 day

**Total Estimated Time**: 1-2 weeks

## Notes for Implementation
- Implement one phase at a time, testing after each
- Keep backups of working configurations
- Test on non-critical host first (recommend fawkes/VM)
- Each phase should maintain full functionality
- Can rollback individual phases if needed
- Document any discoveries or issues during implementation