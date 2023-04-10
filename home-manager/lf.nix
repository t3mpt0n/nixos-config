{ config, lib, pkgs, ...}:
{
	programs.lf = {
		enable = true;
		settings = {
			ratios = "1:2:4";
		};
		extraConfig = ''
			map <backspace2> set hidden!
			map gn cd /etc/nixos
			map gr cd -
		'';
	};
}
