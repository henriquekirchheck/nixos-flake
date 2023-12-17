{ config, pkgs, lib, ... }:

{
	gtk = {
		enable = true;
		theme = {
			package = pkgs.catppuccin-gtk.override {
				accents = [ "sapphire" ];
				size = "compact";
				variant = "mocha";
				tweaks = [ "black" ];
			};
	    name = "Catppuccin-Mocha-Compact-Sapphire-Dark";
		};
		iconTheme = {
			package = pkgs.papirus-icon-theme;
	    name = "Papirus-Dark";
		};
		cursorTheme = {
			package = pkgs.phinger-cursors;
			name = "phinger-cursors-light";
			size = 24;
		};
	};
}
