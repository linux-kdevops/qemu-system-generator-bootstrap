{ config, knix, ... }:
{
  imports = [
    knix.nixosModules.profiles.devel
    ./home.nix
  ];

  networking.hostName = "bootstrap";

  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA... bootstrap" ];
  users.users.${config.knix.user.name}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAA... bootstrap"
  ];
}
