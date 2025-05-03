{
  description = "My nix flakes hihi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs :
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.stevica = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
	  {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.stevica = import ./home.nix;

          }

          {
            nixpkgs.config.allowUnfree = true;
	    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
	      "steam"
	      "steam-original"
	      "steam-unwrapped"
	      "steam-run"
	    ];

          }
        ];
      };
    };
}

