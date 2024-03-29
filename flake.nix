{
  description = "Flake for Henrique's system";

  outputs = { nixpkgs, home-manager, rust-overlay, nix-vscode-extensions, hyprland, catppuccin-vsc, nixvim, blender-bin, ... } @ inputs :
  let
    ### OPTIONS
    # System Options
    system = "x86_64-linux";
    profile = "pc";
    timeZone = "America/Sao_Paulo";
    mainLocale = "en_US.UTF-8";
    extraLocale = "pt_BR.UTF-8";

    # User options
    username = "henrique";
    name = "Henrique Kirch Heck";
    email = "86362827+henriquekirchheck@users.noreply.github.com";
    wm = "hyprland";
    terminal = "kitty";
    browser = "firefox";
    mainEditor = "codium";
    editor = "nvim";
    dotfilesDir = ".dotfiles";

    ### DERIVED ARGUMENTS
    someArgs = {
      inherit system;
      inherit timeZone;
      inherit mainLocale;
      inherit extraLocale;
      inherit wm;
      inherit username;
      inherit name;
      inherit email;
      inherit terminal;
      inherit browser;
      inherit mainEditor;
      inherit editor;
      inherit dotfilesDir;
      inherit inputs;
      inherit profile;
    };
    profilePath = ./profiles/${profile};

    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };
      overlays = [
        rust-overlay.overlays.default
        catppuccin-vsc.overlays.default
        blender-bin.overlays.default
      ];
    };
  in {
    # NixOS System Configuration
    nixosConfigurations.system = lib.nixosSystem {
      inherit system;
      modules = [ nixvim.nixosModules.nixvim (profilePath + "/configuration.nix") ];
      specialArgs = (someArgs // { inherit lib; });
    };

    # Home Manager Configuration
    homeConfigurations.system = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ hyprland.homeManagerModules.default nixvim.homeManagerModules.nixvim (profilePath + "/home.nix") ];
      extraSpecialArgs = someArgs;
    };

    # Universal Packages
    packages.${system} = {
      neovim = nixvim.legacyPackages.${system}.makeNixvim (import ./user/app/editor/config/nixvim.nix);
    };
  };


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    catppuccin-vsc.url = "github:catppuccin/vscode";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
  };
}
