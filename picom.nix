{ config, lib, pkgs, ...}:
{
	services.picom = {
		enable = true;
		vSync = true;
	};
}
