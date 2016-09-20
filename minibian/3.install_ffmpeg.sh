#!/bin/bash
# Get and compile ffmpeg
cd /usr/src
git clone git://git.videolan.org/x264
cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make
make install

cd ..
git clone git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
apt-get -y install libmp3lame-dev libomxil-bellagio-dev
./configure --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-libmp3lame --enable-omx-rpi --disable-debug --enable-version3 --enable-nonfree
make -j4
make install
