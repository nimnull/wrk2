FROM alpine

# ENV LUA_MAJOR_VERSION 5.3
# ENV LUA_MINOR_VERSION 3
# ENV LUA_VERSION ${LUA_MAJOR_VERSION}.${LUA_MINOR_VERSION}

WORKDIR /

RUN apk add --no-cache ca-certificates \
                       readline \
                       libgcc \
                       lua \
    && apk add --no-cache --virtual .build-deps \
        alpine-sdk \
        openssl-dev \
        curl \
        unzip \
        readline-dev \
        lua-dev \
    # Install Lua and LuaRocks
    # && curl -L http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz | tar xzf - \
    # && cd lua-${LUA_VERSION} \
    # && make linux test && make install && rm -rf  /lua-$LUA_VERSION \
    && curl -L https://luarocks.org/releases/luarocks-2.4.1.tar.gz | tar xzf - \
    && cd luarocks-2.4.1 \
    && ./configure && make install \
    # install wrk2
    && cd /root && curl -LO https://github.com/giltene/wrk2/archive/master.zip \
    && unzip master.zip && cd wrk2-master && make \
    && cp wrk /usr/local/bin \
    # clean mess
    && rm -rf /root/wrk2-master /root/master.zip /luarocks-2.4.1 \
    && cd / \
    && luarocks install lbase64 \
    && apk del .build-deps

# ENV WITH_LUA /usr/local/
# ENV LUA_LIB /usr/local/lib/lua/5.3/
# ENV LUA_INCLUDE /usr/local/include

ENTRYPOINT ["/usr/local/bin/wrk"]

