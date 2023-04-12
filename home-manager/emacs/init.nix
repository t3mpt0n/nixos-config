{ config, lib, pkgs, callPackage, ...}:
with lib;
let
	cfg = config.t3mpt0n.emacs;
in {
	imports = [
		./packages.nix
	];
	options.t3mpt0n.emacs.enable = mkEnableOption "emacs service";

	config = mkIf cfg.enable {
		services.emacs = {
			enable = true;
			defaultEditor = true;
			package = pkgs.emacsUnstable;
			client.arguments = [ "-c" "-a" "'emacs'" ];
		};
	};
}
