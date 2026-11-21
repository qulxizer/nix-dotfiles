{
  description = "Mahdi's Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";
    sops-nix.url = "github:Mic92/sops-nix";
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      prismlauncher,
      catppuccin,
      sops-nix,
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
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin
          sops-nix.nixosModules.sops
          ({ ... }: {
            home-manager.sharedModules = [
              catppuccin.homeModules.catppuccin
            ];
          })
        ];
      };
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [
          ./hosts/workstation/home.nix
          catppuccin.homeModules.catppuccin
        ];
      };
      homeConfigurations.mac = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [ ./hosts/mac/home.nix ];
      };
    };
}
