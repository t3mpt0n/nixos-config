{ config, lib, pkgs, ...}:
{
	programs = {
		git = {
			enable = true;
			userEmail = "t3mpt0n@tutanota.com";
			userName = "t3mpt0n";

			signing = {
				key = "~/.ssh/id_rsa.pub";
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
				commit.gpgSign = true;
				gpg.format = "ssh";
			};
		};
	};
}
