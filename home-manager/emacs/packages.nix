{ config, lib, pkgs, ...}:
with lib;
let
	cfg = config.t3mpt0n.emacs.packages;
in {
	options.t3mpt0n.emacs.packages = mkEnableOption "emacs packages";

	config = mkIf cfg {
		programs.emacs = {
			extraPackages = epgks: with pkgs.emacsPackages; [
				use-package
				ligature
				undo-tree
				doom-themes
				doom-modeline
				smartparens
				vterm
				eglot
				eglot-java
				magit
				nix-mode ];
		};
	};
}
