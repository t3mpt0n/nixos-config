{ config, lib, pkgs, ...}:
{
	services.sxhkd = {
		enable = true;
		keybindings = {
			"super + shift + Return" = "kitty"; # Terminal
			"super + @space" = "rofi -show run"; # Rofi
			"super + Escape" = "pkill -USR1 -x sxhkd"; # Reload SXHKD
			# Bspwm Hotkeys
			"super + alt + {q,r}" = "bspc {quit,wm -r}"; # Quit and reload BSPWM
			"super + {_+shift + }w" = "bspc node -{c,k}"; # Quit and Close Windows
			"super + {t,shift + t,s,f}" = "bspc node -g {tiled,pseudo_tiled,floating,fullscreen}"; # Set Window State

			# Apps
			"super + e" = "emacsclient -c -a 'emacs'";
			"super + w" = "firefox";
	};
}
