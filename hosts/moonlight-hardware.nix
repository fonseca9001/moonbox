{
  fileSystems."/" = {
    device = "/dev/sda2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/swapfile";
    size = 8192; # Size in megabytes (8GB)
  }];
}
