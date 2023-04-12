{ config, lib, pkgs, ...}:
with lib;
let
	cfg = config.t3mpt0n.emacs.packages;
in {
	options.t3mpt0n.emacs.packages = mkEnableOption "emacs packages";

	config = mkIf config.t3mpt0n.emacs.enable {
		programs.emacs = {
			enable = true;
		};
	};
}
