# build-strap-cli
This is the CLI (command line interface) for [`build-strap`](https://github.com/murrayju/build-strap). This can be used to bootstrap the bootstrap scripts.

[![CI Build](https://github.com/murrayju/build-strap-cli/workflows/CI/badge.svg?branch=master)](https://github.com/murrayju/build-strap-cli/actions?query=workflow%3A%22CI+Build%22)
[![version](https://img.shields.io/github/v/tag/murrayju/build-strap-cli.svg?label=version&sort=semver)](https://github.com/murrayju/build-strap-cli/releases/latest)
[![npm](https://img.shields.io/npm/v/build-strap-cli)](https://npmjs.org/package/build-strap-cli)
[![dependencies](https://img.shields.io/david/murrayju/build-strap-cli.svg)](https://david-dm.org/murrayju/build-strap-cli)
[![devDependencies](https://img.shields.io/david/dev/murrayju/build-strap-cli.svg)](https://david-dm.org/murrayju/build-strap-cli?type=dev)

## Setup
To set up a new project, copy the `bs` script(s) from this repo into your project and check them in.

```
curl -o bs https://raw.githubusercontent.com/murrayju/build-strap-cli/master/bs && chmod +x bs
curl -o bs.ps1 https://raw.githubusercontent.com/murrayju/build-strap-cli/master/bs.ps1
curl -o bs.bat https://raw.githubusercontent.com/murrayju/build-strap-cli/master/bs.bat
```

Running the `bs` script will download the other needed scripts from `github`. Checking these in to your repo is _optional_.
