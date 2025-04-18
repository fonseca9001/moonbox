{ config, pkgs, ... }:

let
  sessionScript = pkgs.writeShellScriptBin "moonlight-session" ''
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
    export LIBVA_DRIVER_NAME=iHD
    exec ${pkgs.gamescope}/bin/gamescope -- \
         ${pkgs.moonlight-qt}/bin/moonlight
  '';
in
{
  systemd.user.services.moonlight-session = {
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${sessionScript}/bin/moonlight-session";
      Restart = "always";
      Environment = "XDG_SESSION_TYPE=wayland";
    };
  };
}
