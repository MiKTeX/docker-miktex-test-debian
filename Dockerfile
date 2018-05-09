FROM debian:stretch

LABEL Description="MiKTeX test environment, Debian 9" Vendor="Christian Schenk" Version="2.9.5703"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           cmake \
	   dirmngr \
           curl \
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
