{ config, pkgs, ... }:

{
	# Modules
	imports = [
		./git.nix
		./picom.nix
		./windowmanager.nix
		./sxhkd.nix
		./kitty.nix
		./rofi.nix
		./lf.nix
		./emacs/init.nix
		./kodi.nix
		./sway.nix
	];

	t3mpt0n = {
		emacs = {
			enable = true;
			packages = true;
		};
	};

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jd";
  home.homeDirectory = "/home/jd";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
		firefox
		fira-code
		fira-code-symbols
		kitty-themes
		cmake
		libvterm
		wl-clipboard
		keepassxc
		mako
		shotman
		unstable.discord
		nil
		home-manager
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jd/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
		BROWSER = "firefox";
		TERMINAL = "kitty";
  };

  programs = {
		home-manager = {
			enable = true; # Let Home Manager install and manage itself
		};
	};
}
