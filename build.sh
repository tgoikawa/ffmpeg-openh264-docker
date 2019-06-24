#!/bin/sh

wd=/workdir

mkdir -p $wd
cd $wd


echo 'download files'
mkdir openh264bin
git clone -b v2.0.0 --depth 1 --single-branch https://github.com/cisco/openh264.git && \
make -C $wd/openh264 -j `nproc` && \
sudo make -C $wd/openh264 install && \
sudo ldconfig &
git clone -b n4.1.3 --depth 1  --single-branch https://git.ffmpeg.org/ffmpeg.git &
curl -o $wd/openh264bin/libopenh264-2.0.0-linux64.5.so.bz2 http://ciscobinary.openh264.org/libopenh264-2.0.0-linux64.5.so.bz2 &
wait


cd $wd/openh264bin
bunzip2 libopenh264-2.0.0-linux64.5.so.bz2
cp libopenh264-2.0.0-linux64.5.so /usr/local/lib/libopenh264.so.2.0.0
rm /usr/local/lib/libopenh264.a

cd $wd/ffmpeg
./configure --enable-libopenh264 --enable-gpl --enable-nonfree --enable-libfdk-aac
make -j `nproc`
make install

cd /
rm -rf $wd
