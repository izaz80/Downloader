#!/bin/bash

# ==============================================================
# PROJECT: Downloader
# DESCRIPTION: Ultra-quality CLI downloader for Termux/Linux
# AUTHOR: [Your Name/Github Username]
# ==============================================================

# --- CONFIGURATION ---
# We use a variable for the path so it's easy for users to change
SAVE_DIR="/sdcard/downloaded_reels/"
mkdir -p "$SAVE_DIR"

# COOKIE CONFIG: 
# To download private content, place 'cookies.txt' in this folder 
# and the script will automatically detect and use it.
COOKIE_FILE="cookies.txt"
if [ -f "$COOKIE_FILE" ]; then
    COOKIE_SETTING="--cookies $COOKIE_FILE"
else
    COOKIE_SETTING=""
fi

# USER AGENT: Spoofing a browser to prevent bot detection/bans
UA="--user-agent Mozilla/5.0_(Windows_NT_10.0;_Win64;_x64)_AppleWebKit/537.36"

# --- ARGUMENT HANDLING ---
# $1 is the first word after 'dl', $2 is the second (usually the link)
MODE=$1
URL=$2

# If user provides only a URL, we shift it to the correct variable
if [ -z "$2" ]; then
    URL=$1
    MODE="default"
fi

echo "🚀 Downloader Started | Mode: $MODE"

# --- FLAG BUILDER ---
# --embed-metadata: Saves info like creator & date inside the file
# --ignore-errors: Keeps downloading even if one item in a list fails
BASE_FLAGS="--no-check-certificate $UA $COOKIE_SETTING --embed-metadata --ignore-errors"

# Format String: 'bv+ba/b' fetches best video + best audio
BEST_F="bv+ba/b"

case $MODE in
    "nothum")
        # Video + Audio merged into MKV (best container for quality)
        FLAGS="$BASE_FLAGS -f $BEST_F --merge-output-format mkv"
        ;;
    "thum")
        # Just the image, skips the video stream entirely
        FLAGS="$BASE_FLAGS --write-thumbnail --skip-download"
        ;;
    "aud")
        # -x extracts audio; quality 0 is the highest possible
        FLAGS="$BASE_FLAGS -x --audio-quality 0"
        ;;
    "pl")
        # Downloads every item in a link (Carousel/YouTube Playlist)
        FLAGS="$BASE_FLAGS --yes-playlist --write-thumbnail -f $BEST_F --merge-output-format mkv"
        ;;
    "pl nothum")
        FLAGS="$BASE_FLAGS --yes-playlist -f $BEST_F --merge-output-format mkv"
        ;;
    "pl thum")
        FLAGS="$BASE_FLAGS --yes-playlist --write-thumbnail --skip-download"
        ;;
    "pl aud")
        FLAGS="$BASE_FLAGS --yes-playlist -x --audio-quality 0"
        ;;
    *)
        # Default mode: Single video + Thumbnail
        FLAGS="$BASE_FLAGS --write-thumbnail -f $BEST_F --merge-output-format mkv --no-playlist"
        ;;
esac

# Output Template: Artist_ID_Number.extension
OUT_TEMPLATE="%(uploader)s_%(id)s_%(playlist_index)s.%(ext)s"

# --- EXECUTION ---
# quickjs runtime is required for YouTube signature decryption
yt-dlp --js-runtime quickjs $FLAGS -o "$OUT_TEMPLATE" "$URL"

# --- FILE MIGRATION ---
# Move all possible downloaded formats to the visible storage directory
mv *.mp4 *.mkv *.webm *.mp3 *.m4a *.opus *.aac *.jpg *.webp *.png *.jpeg "$SAVE_DIR" 2>/dev/null

echo "✅ Success! Files are in: $SAVE_DIR"
