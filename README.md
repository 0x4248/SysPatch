# SysPatch

SysPatch is a simple tool to create and apply patches to a system. It is designed to be used with Linux systems.

## How it works

Syspatch creates a `path.tar` which contains the fs structure that will be applied to the system and scripts that will be executed to patch and configure the system.

## Creating a patch

To create a patch, you need to place the files you want to patch in the `src/fs`. The `fs` folder is `/` in the system. So if you want to patch `/etc/hostname`, you need to place the file in `src/fs/etc/hostname`.

In `src` there is a `build.sh` script that will be ran when the `path.tar` is created. This script does the required operations to compile the fs structure and then copies over the built fs to `build/image`.

You can then run `make` to create the `path.tar` file.

## Applying a patch

### Using a deployment server

A deployment server is a server that hosts the `path.tar` file and allows for clients on a network to download and apply the patch.

To use a deployment server, you need to build the path and then host the `path.tar` file on a server. You can then run `make deployment_server` to start the deployment server.

On the client, you can run:

```
curl -o patch.tar http://192.168.64.1:4522/patch.tar && tar -xf patch.tar && sh patch.sh && rm -f patch.sh patch.tar
```

### Using the patch file

You can also use the `path.tar` file directly. You can run:

```
tar -xf path.tar && sh patch.sh && rm -f patch.sh path.tar
```

## Licence

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details