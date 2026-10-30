{ modulesPath, pkgs, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  environment.systemPackages = [ pkgs.fio ];
  networking.hostName = "bootstrap";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA... bootstrap" ]; # from ~/bootstrap/system/ssh/id_ed25519.pub
  users.users.root.initialHashedPassword = "";

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
