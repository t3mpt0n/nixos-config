{ config, lib, pkgs, ...}:
{
	services.picom = {
		enable = false;
		vSync = true;
	};
}
