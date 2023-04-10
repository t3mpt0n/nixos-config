{ config, lib, pkgs, ...}:
let cfg = config.modules.git; in
{
	options = {
		enable = lib.mkEnableOption "enable git";
	};
	config = lib.mkIf cfg.enable {
		programs = {
			git = {
				enable = true;
				userEmail = "t3mpt0n@tutanota.com";
				userName = "t3mpt0n";

				signing = {
					gpgPath = "${pkgs.gnupg}/bin/gpg2";
					key = "2A1E424A544032DE";
					signByDefault = true;
				};

				extraConfig = {
					core = {
						editor = "emacsclient -c -a 'emacs'";
						autocrlf = "input";
					};
					init = {
						defaultBranch = "main";
					};

					color = {
						ui = "auto";
						"status" = {
							branch = "magenta";
							untracked = "cyan";
							unmerged = "yellow";
							header = "bold white";
						};
					};
				};
			};
		};
	};
}
