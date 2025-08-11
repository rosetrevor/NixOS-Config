{
  description = "My Flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
  };

  outputs = { self, nixpkgs, home-manager, proxmox-nixos, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      trevbawt = lib.nixosSystem {
        inherit system;
        modules = [ 
	  ./configuration.nix
	  proxmox-nixos.nixosModules.proxmox-ve

	  ({ pkgs, lib, ... }: {
	    services.proxmox-ve = {
	      enable = true;
	      ipAddress = "192.168.0.90";
	    };

	  nixpkgs.overlays = [
	    proxmox-nixos.overlays.${system}
	  ];
	  })
	];
      };
    };
    homeConfigurations = {
      trevbawt = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
