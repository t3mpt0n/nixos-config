{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {
    self
    , nixpkgs
    , nixpkgs-unstable
		, home-manager
  }:
  let
    system = "x86_64-linux";
    overlay-unstable = system: final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    # sshkey="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcon6Pn5nLNXEuLH22ooNR97ve290d2tMNjpM8cTm2r lunarix@masterbook";
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
						./home-configuration.nix
					];

					# Optionally use extraSpecialArgs
					# to pass through arguments to home.nix
				};
		nixosConfigurations.t3mpt0n-laptop = nixpkgs.lib.nixosSystem
			{
				inherit system;
				specialArgs = { inherit self; };
				modules = [
					({config, pkgs, ...}: { nixpkgs.overlays = [ (overlay-unstable system) ]; })
					./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.jd = import ./home-configuration.nix;
					}
        ];
      };

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  }
