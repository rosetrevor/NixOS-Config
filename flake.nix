{
  description = "My Flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
    yazi.url = "github:sxyazi/yazi";
    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, proxmox-nixos, nixflix, sops-nix, ...}:
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
	      nixflix.nixosModules.default
	      sops-nix.nixosModules.sops

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
                  ensureDatabases = [ 
		    "sleeper_db"
		    "sonarr"
		    "prowlarr"
		  ];
		  ensureUsers = [
		    { name = "sonarr"; ensureDBOwnership = true; }
		    { name = "prowlarr"; ensureDBOwnership = true; }
		  ];
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
