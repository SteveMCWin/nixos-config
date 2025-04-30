{
	programs.bash = {
		enable = true;
		shellAliases = 
		let
			flakePath = "~/nixos-config";
		in
		{
			rebuild = "sudo nixos-rebuild switch --flake ${flakePath}";
			hms = "home-manager switch --flake ${flakePath}";
			#flu = "nix flake update ${flakePath}";
		};
	};
}
