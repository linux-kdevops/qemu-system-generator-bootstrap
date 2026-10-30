{
  boot.kernelParams = [ "console=ttyS0" ];
  boot.loader.timeout = 0;
  image.modules.qemu.image.baseName = "bootstrap";
  image.modules.qemu-efi.image.baseName = "bootstrap";
}
