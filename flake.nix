{
  description = "Mahdi's Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";
    # zen-browser.url = "github:qulxizer/zen-browser-flake";
    # helix.url = "github:helix-editor/helix/master";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # swww.url = "github:LGFae/swww";
    # ags.url = "github:Aylur/ags";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      username = "mahdi";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.mahdi = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          hosts/workstation/configuration.nix
          home-manager.nixosModules.default
        ];
      };
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [ ./hosts/workstation/home.nix ];
      };
    };
}
