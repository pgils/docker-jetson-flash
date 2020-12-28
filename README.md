# docker-jetson-flash
A Docker-ised [balena-os/jetson-flash][jetson-flash].

It runs with following options and is not secure:
- `--privileged`
- `--net=host`
- `-v /dev:/dev`

## Usage
See [balena-os/jetson-flash][jetson-flash] for usage. `djetson-flash` passes all arguments to `jetson-flash` except for the rootfs size option [described below](#rootfs-size).

### Persistent work
If the `-p, --persistent` option is used, the persistent work is kept in a named docker volume (`jetson-flash-$machine`) by default. The `-o, --output` option can be used to specify a local directory instead.

### Rootfs size
The `-s, --size` option can be used to specify the size of `resin-rootA` and `resin-rootB` partitions **in bytes**.

Example for a 950MiB root partition:
```
$ ./djetson-flash -m jetson-nano-emmc -f balena.img -s 998244352
```

### Typical usage example
Flash a Jetson nano with a root partition size of 950MB and make work directory persist:
```
$ djetson-flash -m jetson-nano-emmc -s 998244352 -p -f resin-image-jetson-nano-20201224170905.rootfs.resinos-img
```

[jetson-flash]:https://github.com/balena-os/jetson-flash
