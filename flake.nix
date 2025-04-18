{
  description = "Moonlight appliance running in gamescope";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.moonbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hosts/moonlight.nix ];
    };
  };
}
