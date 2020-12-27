FROM node:15-buster as build

COPY jetson-flash /jetson-flash
WORKDIR /jetson-flash
RUN npm install

FROM node:15-buster-slim

# https://github.com/hadolint/hadolint/wiki/DL3009
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
    python3 sudo xmlstarlet \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1

COPY --from=build /jetson-flash /jetson-flash
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
