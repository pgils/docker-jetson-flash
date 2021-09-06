FROM node:fermium-buster as build

COPY jetson-flash /jetson-flash
WORKDIR /jetson-flash
# remove symlink to non-existing parent .git
# to prevent breaking some node module builds.
RUN rm -f .git \
    && npm install

FROM node:fermium-buster-slim

# https://github.com/hadolint/hadolint/wiki/DL3009
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
    python3=3.7* perl=5.28* sudo=1.8* xmlstarlet=1.6* xxd=2:8.* \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1

COPY --from=build /jetson-flash /jetson-flash
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
