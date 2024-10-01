{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:qulxizer/zen-browser-flake";
    helix.url = "github:helix-editor/helix/master";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    swww.url = "github:LGFae/swww";
    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      username = "qulx";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.qulx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          hosts/workstation/configuration.nix
        ];
      };
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        # pkgs = import nixpkgs { inherit system; };

        # pass inputs as specialArgs
        extraSpecialArgs = { inherit inputs system; };
        # import your home.nix
        modules = [
          hosts/workstation/home.nix
        ];
      };

    };
}
