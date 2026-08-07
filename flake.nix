{
  description = "Mahdi's Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen-browser.url = "github:qulxizer/zen-browser-flake";
    # helix.url = "github:helix-editor/helix/master";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # swww.url = "github:LGFae/swww";
    # ags.url = "github:Aylur/ags";
    
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      username = "mahdi";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.mahdi = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          # home-manager.nixosModules.home-manager
          hosts/workstation/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users."${username}" = hosts/workstation/home.nix;
            };
          }
        ];
      };
    };
}
