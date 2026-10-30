{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  networking.hostName = "bootstrap";
  networking.useNetworkd = true;
  systemd.network.networks = {
    "10-lan-bootstrap" = {
      matchConfig.MACAddress = "52:54:00:00:00:47";
      address = [ "10.0.100.47/24" ];
    };
    "10-lan-peer" = {
      matchConfig.MACAddress = "52:54:00:00:00:48";
      address = [ "10.0.100.48/24" ];
    };
  };
  services.openssh.enable = true;
  services.openssh.hostKeys = [
    {
      type = "ed25519";
      path = "/etc/ssh/ssh_host_ed25519_key";
    }
  ];
  security.pam.services.sshd.startSession = lib.mkForce false;
  console.enable = false;
  systemd.suppressedSystemUnits = [
    "systemd-journal-catalog-update.service"
    "systemd-update-done.service"
  ];
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA... bootstrap" ]; # from ~/bootstrap/system/ssh/id_ed25519.pub
  users.users.root.initialHashedPassword = "";

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
