#!/bin/bash
# Make Emby use this ffmpeg version:
nano /usr/bin/emby-server
 
# change:
# FFMPEG_BIN=$(command -v ffmpeg)
# to
# FFMPEG_BIN=/usr/local/bin/ffmpeg
# and change:
# FFPROBE_BIN=$(command -v ffprobe)
# to
# FFPROBE_BIN=/usr/local/bin/ffprobe
 
service emby-server restart
