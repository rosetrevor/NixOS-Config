{
  description = "My Flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
    yazi.url = "github:sxyazi/yazi";
    /*nixarr.url = "github:nix-media-server/nixarr";*/
  };

  /*outputs = { self, nixpkgs, home-manager, proxmox-nixos, nixarr, ...}:*/
  outputs = { self, nixpkgs, home-manager, proxmox-nixos, ...}:
    if "server\n" == builtins.readFile ./user_type.txt then
      # Server specific configuration
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
              /* proxmox-nixos.nixosModules.proxmox-ve */

	      /* nixarr.nixosModules.default */

              ({ pkgs, lib, ... }: {
	        /*
                services.proxmox-ve = {
                  enable = true;
                  ipAddress = "192.168.0.90";
                };

                nixpkgs.overlays = [
                  proxmox-nixos.overlays.${system}
                ];

                services.jellyfin = {
                  enable = true;
                      openFirewall = true;
                };
		*/

                services.postgresql = {
                  enable = true;
                  ensureDatabases = [ "sleeper_db" ];
                  authentication = pkgs.lib.mkOverride 10 ''
                  #type database DBuser origin-address auth-method
                  local all      all                   trust
                  host  all      all    127.0.0.1/32   trust
                  host  all      all    ::1/128        trust
                  '';
                };

              
	        networking.interfaces.wlp5s0 = {
                    # useDHCP = false; # Disable automatic IP assignment
                    ipv4.addresses = [
                    {
                      address = "192.168.1.99";
                      prefixLength = 24;
                    }
                  ];
                };
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
      }

    else  
      # Laptop specific configuration
      let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        nixosConfigurations = {
          trevbawt = lib.nixosSystem {
            inherit system;
            modules = [ ./configuration.nix ];
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
