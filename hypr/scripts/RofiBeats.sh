#!/bin/bash

# Directory for icons
iDIR="$HOME/.config/dunst/icons"

# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(
  ["Animes OPs 📻🎶"]="https://www.youtube.com/playlist?list=PLRe9ARNnYSY41I4NXMtfHQ2HN2wap_YtX"
  ["Jazz ☕️🎶"]="https://www.youtube.com/playlist?list=PL8F6B0753B2CCA128"
  ["Lofi Girl ☕️🎶"]="https://play.streamafrica.net/lofiradio"
  ["96.3 Easy Rock 📻🎶"]="https://radio-stations-philippines.com/easy-rock"
  ["Ghibli Music 🎻🎶"]="https://youtube.com/playlist?list=PLNi74S754EXbrzw-IzVhpeAaMISNrzfUy&si=rqnXCZU5xoFhxfOl"
  ["Top Youtube Music 2023 ☕️🎶"]="https://youtube.com/playlist?list=PLDIoUOhQQPlXr63I_vwF9GD8sAKh77dWU&si=y7qNeEVFNgA-XxKy"
  ["Chillhop ☕️🎶"]="http://stream.zeno.fm/fyn8eh3h5f8uv"
  ["SmoothChill ☕️🎶"]="https://media-ssl.musicradio.com/SmoothChill"
  ["Relaxing Music ☕️🎶"]="https://youtube.com/playlist?list=PLMIbmfP_9vb8BCxRoraJpoo4q1yMFg4CE"
  ["Korean Drama OST 📻🎶"]="https://youtube.com/playlist?list=PLUge_o9AIFp4HuA-A3e3ZqENh63LuRRlQ"
)

# Function for displaying notifications
notification() {
  dunstify -h string:x-canonical-private-synchronous:sys-notify -u normal -i "$iDIR/music.png" "Playing now: $@"
}

# Main function
main() {
  choice=$(printf "%s\n" "${!menu_options[@]}" | rofi -dmenu -config ~/.config/rofi/config-rofi-Beats.rasi -i -p "")

  if [ -z "$choice" ]; then
    exit 1
  fi

  link="${menu_options[$choice]}"

  notification "$choice"
  
  # Check if the link is a playlist
  if [[ $link == *playlist* ]]; then
    mpv --shuffle --vid=no "$link"
  else
    mpv "$link"
  fi
}

# Check if an online music process is running and send a notification, otherwise run the main function
pkill -f http && dunstify -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/music.png" "Online Music stopped" || main
