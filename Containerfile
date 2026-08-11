FROM ubuntu:26.04 AS source

ADD --checksum=sha256:dae68192ad43a59a68df06454eb5fa4e9a9f86a343fe430165efd8b18863d0f4 \
    https://github.com/localsend/localsend/releases/download/v1.18.0/LocalSend-1.18.0-linux-x86-64.deb \
    /tmp/localsend.deb

FROM ghcr.io/containerpak/gtk:main

COPY --from=source /tmp/localsend.deb /tmp/localsend.deb

RUN apt update && \
    apt install -y --no-install-recommends /tmp/localsend.deb libayatana-appindicator3-1 && \
    rm /tmp/localsend.deb && \
    cpak-clean-junk
