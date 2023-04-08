{config, lib, pkgs, ...}:

{
	programs = {
		git = {
			enable = true;
			userEmail = "t3mpt0n@tutanota.com";
			userName = "t3mpt0n";
			signing = {
				gpgPath = "${pkgs.gnupg}/bin/gpg2";
				key = "C929FD1CAAB526A5";
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
}
