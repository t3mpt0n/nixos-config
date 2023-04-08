# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
#     boot.loader.systemd-boot.enable = true;
#     boot.loader.efi.canTouchEfiVariables = true;
	boot = {
		loader.efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/";
		};
		loader.grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
			enableCryptodisk = true;
			gfxmodeEfi = "1024x768";
			# useOsProber = true;
		};
		initrd = {
			availableKernelModules = [
				"cryptd"
			];
			luks.devices = {
				cryptlvm = {
					device = "/dev/disk/by-uuid/ef6af3e5-1d46-4b0a-9a82-6a8e5dd7e4fc";
					# preLVM = true;
					allowDiscards = true;
				};
			};
		};
	};


  networking.hostName = "t3mpt0n-laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
    # services.xserver.displayManager.gdm.enable = true;
#   services.xserver.desktopManager.gnome.enable = true;
	services.xserver = {
		displayManager = {
			startx.enable = true;
			lightdm.enable = lib.mkForce false;
			gdm.enable = lib.mkForce false;
		};
		windowManager = {
			bspwm.enable = true;
		};
	};
	environment.etc = {
		"X11/xinit/xinitrc".text = ''
		#!/bin/sh
		exec bspwm
		'';
	};

	# Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

	# Enable OpenGL
	hardware.opengl = {
		enable = true;
		driSupport = true;
	};

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jd = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      thunderbird
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim 
    wget
    emacs
    openssh
    neofetch
		git
		doas
		unstable.discord
		gnupg
  ];

  nix = {
  	settings = {
		experimental-features = [ "nix-command" "flakes" ];
		auto-optimise-store = true;
	};
	gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	  };
  };

	security = {
		doas = {
			enable = true;
			extraRules = [{
				users = [ "jd" ];
				keepEnv = true;
				persist = true;
			}];
		};
		sudo.enable = false;
	};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
  	enable = true;
		passwordAuthentication = false;
		kbdInteractiveAuthentication = false;
	# permitRootLogin = "yes";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

