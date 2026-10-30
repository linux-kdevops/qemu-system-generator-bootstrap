{
  boot.kernelParams = [ "console=ttyS0" ];
  boot.loader.grub.enable = false;
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "mode=0755" ];
  };
  fileSystems."/nix/store" = {
    device = "store";
    fsType = "virtiofs";
  };
  systemd.services.systemd-boot-random-seed.enable = false;
}
