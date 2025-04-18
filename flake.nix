{
  description = "Moonlight appliance running in gamescope";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
 };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        nixosConfigurations.moonlight-box = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/moonlight.nix ];
        };
      });
}
