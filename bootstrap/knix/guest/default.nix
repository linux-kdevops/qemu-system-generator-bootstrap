# SPDX-License-Identifier: copyleft-next-0.3.1
#
# Per-VM overrides for the imageless template.
#
# The flake passes knix and the flake inputs via specialArgs
# so this module can pull in test-suite modules (LTP, fstests, and so
# on) and reference local source checkouts without having to edit
# flake.nix again.
{
  config,
  lib,
  pkgs,
  knix,
  inputs,
  ...
}:
{
  imports = [
    # Development tools (editors, tracing, kernel dev comfort). Drop
    # this import for a minimal VM that only runs a specific test suite.
    knix.nixosModules.profiles.devel

    # Pick the test-suite modules that match what you intend to
    # run, for example:
    #   knix.nixosModules.profiles.build-tools
    #   knix.nixosModules.testSuites.fstests
    #   knix.nixosModules.testSuites.blktests
    ./home.nix
  ];

  networking.hostName = "bootstrap";
  systemd.network.networks = {
    "10-lan-bootstrap" = {
      matchConfig.MACAddress = "52:54:00:00:00:49";
      address = [ "10.0.100.49/24" ];
    };
    "10-lan-peer" = {
      matchConfig.MACAddress = "52:54:00:00:00:50";
      address = [ "10.0.100.50/24" ];
    };
  };
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

  # Build a package from a local source checkout. The matching
  # fio-src input must be declared in flake.nix.
  # nixpkgs.overlays = [
  #   (final: prev: { fio = prev.fio.overrideAttrs { src = inputs.fio-src; patches = []; }; })
  # ];

  # SSH keys for the root and unprivileged accounts.
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA... bootstrap" ]; # from ~/bootstrap/system/ssh/id_ed25519.pub
  users.users.${config.knix.user.name}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAA... bootstrap"
  ]; # from ~/bootstrap/system/ssh/id_ed25519.pub
}
