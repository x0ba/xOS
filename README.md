# xOS

[![xOS Build Desktop](https://github.com/x0ba/xos/actions/workflows/build-desktop.yml/badge.svg)](https://github.com/x0ba/xos/actions/workflows/build-desktop.yml)

These are my personal Universal Blue image builds, customized with a few extras to make life good on my laptops and home servers.


## Under the Hood

There's a single image name `xos` with multiple tags. The idea is, *I run **xOS** for all my use cases.*


### Desktops

Desktop(and laptop) images are built upon [Bluefin](https://github.com/ublue-os/bluefin).

- `bos:bluefin` - a Bluefin stable-daily image with ZFS support
- `bos:bluefin-nvidia` - a Bluefin stable-daily image with ZFS and Nvidia support
- `bos:bluefin-dx` - a Bluefin stable-daily image with ZFS support and extra developer features
- `bos:bluefin-dx-nvidia` - a Bluefin stable-daily image with ZFS and Nvidia support and extra developer features

## How to Install

Use the installation method for the respective upstream, Bluefin, uCore, etc.

Then switch to **bOS** with a command like:

```
sudo bootc switch --enforce-container-sigpolicy ghcr.io/x0ba/xos:TAG
```

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/) using. You can verify the signature by running the following command:

```
cosign verify --key cosign.pub ghcr.io/x0ba/xos:TAG
```

## DIY

This repo was built on the [Universal Blue Image Template](https://github.com/ublue-os/image-template) though it's been added to significantly.

That template can be used to extend any image you like, Aurora, Bazzite, Bluefin, uCore or even **xOS** so you can make your own ***xOS***!

Also, if you just want to tinker, the images built here can be built locally using [`just`](https://just.systems/) and the provided `Justfile`.

```
# example
just build bluefin
```
