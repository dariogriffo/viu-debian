![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/dariogriffo/viu-debian/total)
![GitHub Downloads (all assets, latest release)](https://img.shields.io/github/downloads/dariogriffo/viu-debian/latest/total)
![GitHub Release](https://img.shields.io/github/v/release/dariogriffo/viu-debian)
![GitHub Release Date](https://img.shields.io/github/release-date/dariogriffo/viu-debian)

<h1>
   <p align="center">
     <a href="https://github.com/atanunq/viu"><img src="https://github.com/dariogriffo/viu-debian/blob/main/debian-logo.png" alt="Debian Logo" width="104" style="margin-left: 20px"></a>
     <br>viu for Debian
   </p>
</h1>
<p align="center">
 viu is a small command-line application to view images from the terminal written in Rust.
</p>

# viu for Debian

This repository contains build scripts to produce the _unofficial_ Debian packages
(.deb) for [viu](https://github.com/atanunq/viu/) hosted at [debian.griffo.io](https://debian.griffo.io)

<p align="center">
⭐⭐⭐ Love using viu on Debian? Show your support by starring this repo or [subscribing](https://buy.stripe.com/aFa28q8hr0lRdlm4a2enS01) — access to this repository requires a yearly subscription. ⭐⭐⭐
</p>

Currently supported debian distros are:
- Bookworm
- Trixie
- Sid

This is an unofficial community project to provide a package that's easy to
install on Debian. If you're looking for the viu source code, see
[viu](https://github.com/atanunq/viu/).

## Install/Update

📖 **Step-by-step install guide:** [Debian](https://debian.griffo.io/install-latest-viu-in-debian.html) · [Ubuntu](https://debian.griffo.io/install-latest-viu-in-ubuntu.html)

### The Debian way

```sh
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt update
sudo apt install -y viu
```

### Manual Installation

1. Download the .deb package for your Debian version available on
   the [Releases](https://github.com/dariogriffo/viu-debian/releases) page.
2. Install the downloaded .deb package.

```sh
sudo dpkg -i <filename>.deb
```
## Updating

To update to a new version, just follow any of the installation methods above. There's no need to uninstall the old version; it will be updated correctly.

## Roadmap

- [x] Produce a .deb package on GitHub Releases
- [x] Set up a debian mirror for easier updates

## Disclaimer

- This repo is not open for issues related to viu. This repo is only for _unofficial_ Debian packaging.
