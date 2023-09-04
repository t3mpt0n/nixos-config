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
		programs.emacs.enable = true;
		services.emacs = {
			enable = true;
			defaultEditor = true;
			package = pkgs.emacs-unstable;
			client.arguments = [ "-c" "-a" "'emacs'"];
		};
	};
}
