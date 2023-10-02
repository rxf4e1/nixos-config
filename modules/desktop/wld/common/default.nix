{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let

  bright = pkgs.writeShellScriptBin "bright" ''
    ARG="$@"
    ICON="$HOME/.icons/candy-icons/apps/scalable/gtk-redshift.svg"

    CMD=""
    # if [[ \${pkgs.light} ]]; then
    #    $CMD=${pkgs.light}
    # else {
    #    echo "Program not found!"
    # }

    case $ARG in
       up)
	       light -A 10.0
	       ;;
       down)
	       light -U 10.0
	       ;;
    esac

    notify-send -u low -a control -t 1000 -h int:value:$(light -G) -i $ICON "Brightness"
  '';
  
  # vol = pkgs.writeShellScriptBin "vol" ''
  #   ARG="$@"
  #   # PID=$(pidof -x pulsemixer)
  #   VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2)
  #   ICON="$HOME/.icons/candy-icons/apps/scalable/ocenaudio.svg"


  #   # if [[ ! $PID ]]; then
  #   #     footclient -a float -w 600x100 -e pulsemixer
  #   # fi

  #   case $ARG in
  #      up)
	#        wpctl set-volume @DEFAULT_SINK@ 5%+;
  #        notify-send -u low -h int:value:"$(echo "$VOL * 100" | bc)" -i $ICON "Vol (+/-)" -t 1000
	#        ;;
  #      down)
	#        wpctl set-volume @DEFAULT_SINK@ 5%-;
  #        notify-send -u low -h int:value:"$(echo "$VOL * 100" | bc)" -i $ICON "Vol (+/-)" -t 1000
	#        ;;
  #      mute)
  #        wpctl set-mute @DEFAULT_SINK@ toggle;
  #        notify-send -u low -h int:value:"$(echo "$VOL * 100" | bc)" -i $ICON "(Un)MUTED" -t 1000
	#        ;;
  #   esac
  #   # notify-send -u low -h int:value:"$(echo "$VOL * 100" | bc)" Volume󰋌 -t 1000
  # '';
  
  cfg = config.modules.desktop.wld.common;
in {
  options.modules.desktop.wld.common = {enable = mkEnableOption "Common";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cliphist
      grim
      slurp
      jq
      kanshi
      # rofi-wayland
      fuzzel
      playerctl
      wl-clipboard
      wlsunset
      # wob
      libinput
      swaybg
      swayimg
      
      # vol
      bright
    ];

    home.sessionVariables = {
      GDK_BACKEND = "wayland";
      GDK_SCALE = "1";
      CLUTTER_BACKEND = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland-egl";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBSEAT_BACKEND = "logind";
    };
  };
}
