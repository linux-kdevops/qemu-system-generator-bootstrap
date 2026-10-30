{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations.bootstrap = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./virtiofs.nix
        ];
      };
      packages.x86_64-linux.default = self.nixosConfigurations.bootstrap.config.system.build.toplevel;
    };
}
