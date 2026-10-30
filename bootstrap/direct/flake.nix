{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    {
      overlays.default = import ./overlay.nix;

      nixosConfigurations.bootstrap = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./virtiofs.nix
          ./home.nix
          { nixpkgs.overlays = [ self.overlays.default ]; }
        ];
      };
      packages.x86_64-linux = {
        default = self.nixosConfigurations.bootstrap.config.system.build.toplevel;
        inherit (self.nixosConfigurations.bootstrap.pkgs) fio;
      };
    };
}
