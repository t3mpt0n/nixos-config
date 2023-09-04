{config, lib, pkgs, ...}:
{
	wayland.windowManager.sway = {
		enable = true;
		config = rec {
			modifier = "Mod4";
			output = {
				"Virtual-1" = {
					mode = "1920x1080@60Hz";
				};
			};
			keybindings = with lib;
				let
					modifier = config.wayland.windowManager.sway.config.modifier;
				in mkOptionDefault {
					"${modifier}+Shift+Return" = "exec ${pkgs.kitty}/bin/kitty";
					"${modifier}+Shift+q" = "kill";
					"${modifier}+p" = "exec ${pkgs.rofi}/bin/rofi -show run";
					"${modifier}+e" = "exec ${pkgs.emacs}/bin/emacsclient -c -a 'emacs'";
					"${modifier}+d" = "exec ${pkgs.discord}/bin/discord";
					"${modifier}+w" = "exec ${pkgs.firefox}/bin/firefox";
					"${modifier}+Alt+w" = "layout tabbed";
					"${modifier}+Alt+e" = "layout toggle split";
					"${modifier}+Alt+v" = "splitv";
					"${modifier}+Alt+h" = "splith";
				};
		};
		extraSessionCommands = ''
			export SDL_VIDEODRIVER=wayland
			export QT_QPA_PLATFORM=wayland
			export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
			export _JAVA_AWT_WM_NONREPARENTING=1
			export XDG_CURRENT_DESKTOP=sway
			export XDG_SESSION_DESKTOP=sway
		'';
	};
}
