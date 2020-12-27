# docker-jetson-flash
A Docker-ised [balena-os/jetson-flash](https://github.com/balena-os/jetson-flash).

It runs with following options and is not secure:
- `--privileged`
- `--net=host`
- `-v /dev:/dev`

## Persistent work
If the `-p, --persistent` option is used, the persistent work is kept in a docker volume (`jetson-flash-\$machine`). This cannot be changed.

To remove it just delete the volume.  
*example for `jetson-nano-emmc`*:
```
$ docker volume rm jetson-flash-jetson-nano-emmc
```

## Rootfs size
The `-s` option can be used to specify the size of `resin-rootA` and `resin-rootB` partitions **in bytes**.

Example for a 950MiB root partition:
```
$ ./djetson-flash -m jetson-nano-emmc -f balena.img -s 998244352
```
