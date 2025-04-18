{ config, pkgs, ... }:

{
  imports = [ ../modules/gamescope-session.nix ];

  system.stateVersion = "24.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "moonbox";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Lisbon";

  users.users.moonlight = {
    isNormalUser = true;
    initialPassword = "moonlight";
    extraGroups = [ "wheel" "video" "audio" "input" "bluetooth" "networkmanager" ];
    packages = with pkgs; [ moonlight-qt ];
    shell = pkgs.bash;
  };

  services.getty.login."tty1".autologin = {
    enable = true;
    user = "moonlight";
  };


  # SSH access
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.dbus.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
  };

  # Hardware acceleration (Intel iHD)
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  environment.systemPackages = with pkgs; [
    moonlight-qt
    gamescope
    blueman
    pavucontrol
    glxinfo
    vulkan-tools
    vim
    git
  ];

  programs.gamescope.enable = true;
  security.polkit.enable = true;

  # Auto-start moonlight session service for user
  systemd.user.targets.default.wants = [ "moonlight-session.service" ];
}
