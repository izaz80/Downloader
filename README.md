Project Name: Downloader
Description:
Downloader is a shell-based media extraction tool designed for high-fidelity data retrieval. It acts as a wrapper for yt-dlp to ensure the highest possible quality streams are captured in the MKV container with Opus or M4A audio. It is compatible with any environment running Bash, including Linux, macOS, and Android via Termux.
Prerequisites:
To use this script, your system must have the following packages installed:
 1. python3
 2. ffmpeg
 3. yt-dlp
 4. quickjs (required for YouTube signature decryption)
Installation:
 1. Download the dl script to your local machine.
 2. Grant execution permissions by running: chmod +x dl
 3. Move the script to a folder in your system path, such as /usr/local/bin or $PREFIX/bin in Termux, to run it from any directory.
Command Modes:
The script uses specific keywords to toggle between different quality and content settings. Use the following syntax: dl [mode] [url]
Standard Modes:
 1. dl [url]: Downloads the best quality video and the highest resolution thumbnail.
 2. dl nothum [url]: Downloads the best quality video only, skipping the thumbnail.
 3. dl thum [url]: Downloads only the highest resolution thumbnail as an image file.
 4. dl aud [url]: Extracts the absolute best quality audio stream in its native format (usually Opus or M4A).
Playlist and Carousel Modes:
These modes are used for Instagram carousels or YouTube playlists to ensure all items are captured.
 1. dl pl [url]: Downloads every video and every thumbnail in the collection.
 2. dl pl nothum [url]: Downloads every video in the collection without thumbnails.
 3. dl pl thum [url]: Downloads only the thumbnails for every item in the collection.
 4. dl pl aud [url]: Extracts the audio from every item in the collection.
Private Content and Cookies:
If a creator account is private or content is age-restricted, you must provide authentication via a cookies file.
 1. Install a browser extension like Cookie-Editor on your desktop or a mobile browser that supports extensions (like Kiwi Browser).
 2. Log into the platform (Instagram, Facebook, or YouTube).
 3. Export your cookies in the Netscape format.
 4. Save the exported text as a file named cookies.txt in the same directory where you run the script.
 5. The script will automatically detect cookies.txt and use it to bypass login walls.
Technical Details:
 1. Container: The script forces the MKV container in video modes to allow for superior codecs like VP9 and AV1 without re-encoding.
 2. Audio: Audio-only mode uses a quality setting of 0 to ensure no data loss during extraction.
 3. User-Agent: A spoofed Windows Chrome User-Agent is used to minimize the risk of bot detection and IP rate-limiting.
 4. Storage: On Android/Termux, files are moved to /sdcard/downloaded_reels/ for gallery visibility. On other systems, ensure the path is adjusted in the script configuration.
License:
This project is released under the MIT License.
