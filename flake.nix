{
  description = "My nix flakes hihi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.stevica = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

          # ✅ Enable home-manager as part of the system
          home-manager.nixosModules.home-manager

          # ✅ Globally allow unfree packages (for system + home-manager)
          {
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
    };
}

