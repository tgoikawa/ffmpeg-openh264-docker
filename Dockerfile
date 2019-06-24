FROM debian:buster
COPY build.sh /
RUN  sed -i -e 's/deb http:\/\/deb.debian.org\/debian buster main/deb http:\/\/deb.debian.org\/debian buster main contrib non-free/g' /etc/apt/sources.list && \
apt update && apt upgrade -y && \
apt install -y git sudo curl build-essential nasm libfdk-aac-dev && \
/build.sh
