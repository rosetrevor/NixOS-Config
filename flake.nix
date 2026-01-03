{
  description = "My Flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, home-manager, proxmox-nixos, ...}:
    if "server" == builtins.readFile ./user_type.txt then
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
      }
    else
      {};
}
