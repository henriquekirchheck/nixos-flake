{
  description = "Flake for Henrique's system";

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-vscode-extensions,
      hyprland,
      nixvim,
      blender-bin,
      catppuccin,
      disko,
      ...
    }@inputs:
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
        inherit hostName;
      };
      profilePath = ./profiles/${profile};
      hostName = "${username}-${profile}";

      lib = pkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
	  allowUnfreePredicate = _: true;
          android_sdk.accept_license = true;
        };
        overlays = [
          blender-bin.overlays.default
        ];
      };
    in
    {
      # NixOS System Configuration
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        inherit system;
        modules = [
          nixvim.nixosModules.nixvim
          (profilePath + "/configuration.nix")
          disko.nixosModules.disko
          ./disko.nix
        ];
        specialArgs = (someArgs // { inherit lib; });
      };

      # Home Manager Configuration
      homeConfigurations."${username}@${hostName}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          hyprland.homeManagerModules.default
          nixvim.homeManagerModules.nixvim
          catppuccin.homeModules.catppuccin
          (profilePath + "/home.nix")
        ];
        extraSpecialArgs = someArgs;
      };

      # Universal Packages
      packages.${system} = {
        neovim = nixvim.legacyPackages.${system}.makeNixvim (import ./user/app/editor/config/nixvim.nix);
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = {
        hyprland.follows = "hyprland";
      };
    };
    hyprcursor-phinger = {
      url = "github:Jappie3/hyprcursor-phinger";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blender-bin = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
