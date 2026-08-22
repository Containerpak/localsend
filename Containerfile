FROM ubuntu:26.04 AS source

ADD --checksum=sha256:cc42a4f3eacdcb25ec31f0016b1272acb003145ab30484db8965450e20c72cd2 \
    https://github.com/localsend/localsend/releases/download/v1.18.2/LocalSend-1.18.2-linux-x86-64.deb \
    /tmp/localsend.deb

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/localsend.deb,target=/run/localsend.deb \
    apt-get update && \
    apt-get install -y /run/localsend.deb libayatana-appindicator3-1 && \
    cpak-clean-junk
