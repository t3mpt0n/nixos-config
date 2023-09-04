{ config, lib, pkgs, ...}:
{
	xsession.windowManager = {
		bspwm = {
			enable = false;
			settings = {
				border_width = 2;
				window_gap = 12;
				gapless_monocle = true;
				borderless_monocle = true;
				pointer_follows_focus = false;
				focus_follows_pointer = true;
				split_ratio = 0.52;
			};
			extraConfig = ''
				pgrep -x sxhkd > /dev/null || sxhkd &
				bspc monitor -d 1 2 3 4 5 6 7 8 9
				bspc rule -a Emacs state=tiled
				picom -b &
			'';
		};
	};
}
