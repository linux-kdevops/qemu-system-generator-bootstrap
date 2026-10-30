{ lib, ... }:
let
  home = "/home/user";
  mask = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "ro"
      "nosuid"
      "nodev"
      "mode=0555"
    ];
  };
in
{
  fileSystems.${home} = {
    device = "home";
    fsType = "virtiofs";
  };
  fileSystems."${home}/.config/systemd" = mask;
  fileSystems."${home}/.local/share/systemd" = mask;
  fileSystems."${home}/.ssh" = mask;
  users.users.root.home = lib.mkForce home;
}
