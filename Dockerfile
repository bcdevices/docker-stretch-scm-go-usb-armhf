FROM golang:1.15.6-buster

# Setup environment
ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm

# Setup locale
# hadolint ignore=DL3008
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends locales \
  && rm -rf /var/lib/apt/lists/*
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LANG=C.UTF-8

# Install needed packages
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
		crossbuild-essential-arm64 \
		crossbuild-essential-armhf \
		libftdi1-dev \
		libusb-1.0-0-dev \
		unzip \
		zip \
	  && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3008
RUN dpkg --add-architecture armhf \
  && dpkg --add-architecture arm64 \
  && apt-get update \
  && apt-get -y install --no-install-recommends \
		libftdi1-dev \
		libusb-1.0-0-dev:arm64 \
		libusb-1.0-0-dev:armhf \
  && rm -rf /var/lib/apt/lists/*
