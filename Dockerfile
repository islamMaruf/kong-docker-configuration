FROM kong/kong-gateway:2.8.1.0-alpine

LABEL description="Alpine + Kong  + kong-oidc plugin"

USER root

RUN apk update && apk add curl git gcc musl-dev

RUN luarocks install luaossl OPENSSL_DIR=/usr/local/kong CRYPTO_DIR=/usr/local/kong
RUN luarocks install --pin lua-resty-jwt
RUN luarocks install kong-oidc

RUN luarocks install kong-spec-expose

USER kong

ENV KONG_PLUGINS=bundled,oidc,kong-spec-expose