FROM postgres:13

RUN apt-get update -y \
  && apt-get install --no-install-recommends -y \
    git wget ca-certificates make gcc autoconf libtool \
    pkg-config libssl-dev "postgresql-server-dev-$PG_MAJOR=$PG_VERSION" \
  && git clone --recursive https://github.com/EnterpriseDB/mongo_fdw.git \
    /tmp/mongo_fdw \
  && cd /tmp/mongo_fdw \
  && ./autogen.sh --with-master \
  && make \
  && make install \
  && cd / \
  && rm -rf /tmp/mongo_fdw \
  && apt-get remove -y \
    git wget make gcc autoconf libtool \
    pkg-config libssl-dev "postgresql-server-dev-$PG_MAJOR=$PG_VERSION" \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*
