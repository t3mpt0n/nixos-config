{ config, lib, pkgs, callPackage, ...}:
{
	programs.emacs = {
		enable = true;
	};

	services.emacs = {
		enable = true;
		defaultEditor = true;
		package = pkgs.emacsUnstable;
		client.arguments = [ "-c" "-a" "'emacs'" ];
	};
}
