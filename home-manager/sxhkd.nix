{ config, lib, pkgs, ...}:
{
	services.sxhkd = {
		enable = true;
		keybindings = {
			"super + Escape" = "pkill -USR1 -x sxhkd"; # Reload SXHKD
			"XF86AudioMute" = "amixer set Master toggle"; # Mute Sound
			"XF86Audio{Raise,Lower}Volume" = "amixer set Master 5%{+,-}"; # Raise or Lower Volume

			# Bspwm Hotkeys
			"super + alt + {q,r}" = "bspc {quit,wm -r}"; # Quit and reload BSPWM
			"super + {_+shift + }q" = "bspc node -{c,k}"; # Quit and Close Windows
			"super + {t,shift + t,s,f}" = "bspc node -g {tiled,pseudo_tiled,floating,fullscreen}"; # Set Window State
			"super + m" = "bspc desktop -l next"; # Alternate Tiled and Monocle
			"super + y" = "bspc node newest.marked.local -n newest.!automatic.local"; # Send newest marked node to newest preselected node
			"super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'"; # Select or Move a window to a different tab
			## Expand and Contract Windows
			"super + alt {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
			"super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
			"super + {grave,Tab}" = "bspc node -v {-20 0,0 20,0 -20,20 0}"; # Move a floating window
			"super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}"; # Set the node flags
			"super + bracket{left,right}" = "bspc {node,desktop} -f last"; # Focus next/prev desktop in monitor
			"super + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on"; # Focus older or newer node in focus history

			# Apps
			"super + e" = "emacsclient -c -a 'emacs'"; # Emacs
			"super + w" = "firefox"; # Firefox
			"super + shift + Return" = "kitty"; # Terminal
			"super + @space" = "rofi -show run"; # Rofi
			"super + d" = "discord";
		};
	};
}
