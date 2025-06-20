# Nix/Home-Manager Configuration Refactoring Plan

This document outlines the refactoring plan for the Nix/Home-Manager configuration based on a comprehensive review. The configuration is structurally sound but has opportunities for improved organization and reduced redundancy.

## Priority 1 - Package Organization

### 1.1 Merge dev-libs.nix into development.nix
- **Rationale**: `dev-libs.nix` contains only `libpng` - too granular for a standalone group
- **Action**: Move `libpng` to `development.nix` and remove `dev-libs.nix`
- **Files to modify**: 
  - `modules/packages/dev-libs.nix` (delete)
  - `modules/packages/development.nix` (add libpng)
  - `lib/mkPackages.nix` (remove dev-libs from desktop profile)

### 1.2 Split system-utils.nix into focused groups
- **Rationale**: Current file is a grab-bag mixing CLI tools, media apps, and desktop utilities
- **Action**: Split into three focused groups:
  - `cli-tools.nix`: fd, ripgrep, fzf, dtrx, eza, zoxide, btop, wget, curl, unzip, file, which, asciinema
  - `media.nix`: mpv, ytermusic, imagemagick, feh
  - `desktop-utils.nix`: nautilus, ksnip, bluetui, steam-run, xclip, light
- **Files to create**: 
  - `modules/packages/cli-tools.nix`
  - `modules/packages/media.nix` 
  - `modules/packages/desktop-utils.nix`
- **Files to modify**:
  - `modules/packages/system-utils.nix` (delete)
  - `lib/mkPackages.nix` (update desktop profile with new modules)

### 1.3 Fix zen-browser placement
- **Rationale**: Currently in `editors.nix` due to "browser everything broke" workaround
- **Action**: Move zen-browser from `editors.nix` to `browsers.nix`
- **Files to modify**:
  - `modules/packages/editors.nix` (remove zen-browser and comment)
  - `modules/packages/browsers.nix` (add zen-browser with inputs reference)

### 1.4 Deduplicate eza package
- **Rationale**: `eza` appears in both `system-utils.nix` and `hosts/solo/home.nix`
- **Action**: Remove `eza` from `hosts/solo/home.nix` since it will be available through cli-tools
- **Files to modify**: `hosts/solo/home.nix`

## Priority 2 - Library Improvements

### 2.1 Make mkHome system-agnostic
- **Rationale**: Hardcoded `x86_64-linux` in `lib/mkHome.nix:11` reduces portability
- **Action**: Add system parameter with default value
- **Files to modify**: `lib/mkHome.nix`

### 2.2 Remove redundant user info from common.nix
- **Rationale**: `home.username/homeDirectory` set in both `common.nix` and overridden by `mkHome`
- **Action**: Remove hardcoded user info from `common.nix`, let mkHome handle it
- **Files to modify**: `modules/home/common.nix`

### 2.3 Standardize package reference style
- **Rationale**: Inconsistent use of `with pkgs;` vs explicit `pkgs.` references
- **Action**: Review and standardize to explicit `pkgs.` for better clarity
- **Files to review**: All package modules for consistent style

## Priority 3 - Cleanup

### 3.1 Handle unused wbp input
- **Rationale**: `wbp` input declared in flake but no usage found
- **Action**: Either remove if truly unused, or document purpose if reserved for future use
- **Files to modify**: `flake.nix`

### 3.2 Review legacy module organization
- **Rationale**: `legacy/i3.nix` and `legacy/tmux.nix` only used by minimal profile
- **Action**: Evaluate if legacy namespace is warranted or if modules should be promoted
- **Files to review**: 
  - `modules/home/legacy/i3.nix`
  - `modules/home/legacy/tmux.nix`
  - `modules/home/profiles/minimal.nix`

### 3.3 Reduce profile coupling
- **Rationale**: Profile system creates tight coupling between lib and module structure
- **Action**: Consider making profiles more independent of internal module structure
- **Files to review**: `lib/mkPackages.nix`

## Priority 4 - Documentation

### 4.1 Add module-level documentation
- **Action**: Add header comments to package modules explaining their purpose and contents
- **Files to modify**: All `modules/packages/*.nix` files

### 4.2 Document profile system
- **Action**: Add comprehensive comments to profile system explaining usage patterns
- **Files to modify**: `lib/mkPackages.nix`

## Implementation Notes

- All host package configurations currently use `lib.profiles.desktop` - verify no functionality is lost during package reorganization
- Test configuration builds after each major change
- The dot-file copying approach is intentionally impure and should not be modified
- Maintain backwards compatibility during refactoring

## Validation Checklist

- [ ] All hosts build successfully: `nix flake check`
- [ ] Package availability maintained across all profiles
- [ ] No duplicate packages remain
- [ ] Profile system still functions correctly
- [ ] Legacy modules properly integrated or relocated