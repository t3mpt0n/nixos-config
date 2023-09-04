{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-23.05";
		emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = {
			self
    , nixpkgs
    , nixpkgs-unstable
		, home-manager
		, emacs-overlay
  }:
  let
    system = "x86_64-linux";
    overlay-unstable = system: final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
		homeConfigurations.jd = let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
			in
				home-manager.lib.homeManagerConfiguration {
					inherit pkgs;

					# Specify your home configuration modules here, for example,
					# the path to your home.nix.
					modules = [
						./home-manager/home.nix
					];

					# Optionally use extraSpecialArgs
					# to pass through arguments to home.nix
				};
		nixosConfigurations.t3mpt0n-laptop = nixpkgs.lib.nixosSystem
			{
				inherit system;
				specialArgs = { inherit self; };
				modules = [
					({config, pkgs, ...}: { nixpkgs.overlays = [ (overlay-unstable system) (import self.inputs.emacs-overlay) ]; })
					./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.jd = import ./home-manager/home.nix;
					}
        ];
      };

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  }
