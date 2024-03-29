# docker-jetson-flash

A Dockerized [balena-os/jetson-flash][jetson-flash].

## Requirements

- Docker
- bash >= 4.0

## Warnings

`djetson-flash` runs a docker container with following options, making it insecure:
- `--privileged`
- `--net=host`
- `-v /dev:/dev`

## Usage

See [balena-os/jetson-flash][jetson-flash] for usage. `djetson-flash` passes all arguments to `jetson-flash` except for the rootfs size option [described below](#rootfs-size).

### Persistent work

If the `-p, --persistent` option is used, the persistent work is kept in a named docker volume (`jetson-flash-$machine`) by default. The `-o, --output` option can be used to specify a local directory instead.

### Rootfs size

The `-s, --size` option can be used to specify the size of `resin-rootA` and `resin-rootB` partitions. Binary prefixes `K`, `M`, `G`, `T` are supported.

Example for a 950MiB root partition:
```
$ ./djetson-flash -m jetson-nano-emmc -f balena.img -s 950M
```

### Typical usage example

Flash a Jetson nano device and preserve work directory as a docker volume:
```
$ djetson-flash -m jetson-nano-emmc -p -f balena-cloud-myfleet-jetson-nano-emmc.img.zip
```

[jetson-flash]:https://github.com/balena-os/jetson-flash
