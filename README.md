# Kubernetes RBACQ

[![Build Status](https://travis-ci.org/sbueringer/securecookiecli.svg?branch=master)](https://travis-ci.org/sbueringer/securecookiecli)

Securecookiecli makes the functionality of [gorilla/securecookie](https://github.com/gorilla/securecookie) available on the commandline.

# Installation

## Binary

Go to the [releases](https://github.com/sbueringer/securecookiecli/releases) page and download the Linux or Windows version. Put the binary to somewhere you want (on UNIX-y systems, /usr/local/bin or the like). Make sure it has execution bits turned on.

# Basic Usage

Securecookiecli is build with [Cobra](https://github.com/spf13/cobra) so the CLI is build in a familiar way (Cobra is also used in Docker and Kubernetes).

To print a description what securecookiecli can do, just execute:
```bash
$ ./securecookiecli
securecookiecli encrypts/ decrypts securecookies

Usage:
  securecookiecli [command]

Available Commands:
  encrypt     Encrypts a securecookie
  decrypt     Decrypts a securecookie
  help        Help about any command

Flags:
  -h, --hash-key            Specifies the hash-key which is used for the securecookie (can also be set with the env variable HASH_KEY)
  -b, --block-key           Specifies the block-key which is used for the securecookie (can also be set with the env variable BLOCK_KEY)

Use "securecookiecli [command] --help" for more information about a command.
```

To further explore the CLI execute the following: (and so on)
```bash
$ ./securecookiecli encode
```
