FROM node:12-buster as build

COPY jetson-flash /jetson-flash
WORKDIR /jetson-flash
RUN set -ex;\
    # remove symlink to non-existing parent .git
    # to prevent breaking some node module builds.
    rm -f .git;\
    # https://github.com/npm/cli/issues/1673
    npm install -g npm@v8;\
    npm install --no-update-notifier --no-package-lock --no-fund --no-audit

FROM node:12-buster-slim

RUN set -ex;\
    apt-get update -qq;\
    apt-get install -qqy --no-install-recommends \
        libarchive-tools=3.* \
        libxml2-utils=2.9* \
        perl=5.28* \
        python3=3.7* \
        sudo=1.8* \
        xmlstarlet=1.6* \
        xxd=2:8.* \
        ;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;\
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1

COPY --from=build /jetson-flash /jetson-flash
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
