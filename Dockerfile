# Nexus PrimePoolMiner
#
# VERSION 1.2.3

FROM alpine:3.7

ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="James Brink, brink.james@gmail.com" \
  decription="Nexus Prime Pool Miner" \
  version="1.2.3" \
  org.label-schema.name="PrimePoolMiner" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/jamesbrink/docker-prime-pool-miner" \
  org.label-schema.schema-version="1.0.0-rc1"

# Create our cpuminer user.
RUN addgroup -g 1000 -S cpuminer \
    && adduser -u 1000 -S -h /cpuminer -s /bin/sh -G cpuminer cpuminer

# Install all needed runtime dependencies.
RUN set -xe; \
      apk add --update --no-cache --virtual .build-deps \
          alpine-sdk \
          automake \
          boost-dev \
          clang \
          git \
          gmp-dev \
          libdbi-dev \
          libgmpxx \
          miniupnpc-dev \
          openssl-dev; \
      apk add --no-cache --virtual .runtime-deps \
          bash \
          boost \
          gmp \
          libdbi \
          openssl; \
      git clone https://github.com/hg5fm/PrimePoolMiner.git /var/tmp/PrimePoolMiner; \
      cd /var/tmp/PrimePoolMiner; \
      ln -s /usr/lib/libboost_thread-mt.so.1.62.0 /usr/lib/libboost_thread.so; \
      make MARCHFLAGS=-march=native -f makefile; \
      mkdir -p /usr/local/lib/; \
      mkdir -p /usr/local/bin/; \
      cp nexus_cpuminer /usr/local/bin/; \
      cp liboaccminer.so /usr/local/lib/; \
      cp miner.conf.solo-example /cpuminer/; \
      cp miner.conf.pool-example /cpuminer/; \
      rm -rf /var/tmp/PrimePoolMiner; \
      chown -R cpuminer:cpuminer /cpuminer; \
      apk del .build-deps; \
      cd /cpuminer;

# Copy our docker assets.
COPY ./ /var/tmp

# Move our assets
RUN set -xe; \
    mv /var/tmp/docker-entrypoint.sh /usr/local/bin/entrypoint.sh; \
    mv /var/tmp/miner.conf /cpuminer/miner.conf.tmpl; \
    chown cpuminer:cpuminer /cpuminer/miner.conf.tmpl;

# Set our ENV variables
ENV PATH="/usr/local/bin:$PATH" \
    HOST="nexusminingpool.com" \
    PORT="9549" \
    ADDRESS="" \
    SIEVE_THREADS=0 \
    PTEST_THREADS=0 \
    TIMEOUT=10 \
    BIT_ARRAY_SIZE=2097152 \
    PRIME_LIMIT=71378571 \
    N_PRIME_LIMIT=3000000 \
    PRIMORIAL_END_PRIME=12 \
    EXPERIMENTAL="true"

# Set our working directory.
WORKDIR /cpuminer

# Drop down to our non privileged user.
USER cpuminer

# Set our entrypoint.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]