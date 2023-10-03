FROM debian:bookworm

LABEL Description="MiKTeX test environment, Debian 12 (bookworm)" Vendor="Christian Schenk" Version="23.10.03"

RUN \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        cmake \
        curl \
	    dirmngr \
        ghostscript \
        gnupg \
        gosu \
        make \
        unzip \
        zip

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/test.sh"]
