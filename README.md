# An `asdf` plugin that manages TigerVNC Java Viewer versions

[![Test](https://github.com/binary-manu/asdf-tigervnc-java-viewer/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/binary-manu/asdf-tigervnc-java-viewer/actions/workflows/build.yml)

This plugin extends `asdf` with the ability to manage versions of the
TigerVNC Java Viewer, released upstream as jar files.

## Usage

For each jar version, the plugin will download it, then create a `bin`
folder with a shell script named `tigervnc` that wraps a call to the jar
file, passing it any additional parameters. This wrapper will be
automatically picked by `asdf` and added to the shims.

Installing a version requires common POSIX tools like `sed`, `grep`,
`tr`. Running a version will additionally require a JRE to run `java`.
The wrapper scripts picks `java` from the `PATH`, so it may well be an
`asdf` shim and thus the Java version can be controlled via `asdf`
environment variables.

## Desktop integration

Since the viewer is a GUI app, it may be useful to integrate it with the
DE via a menu entry. Two additional, optional commands, can do this:

* `integrate` creates a `.desktop` file for every installed viewer
  version. Each version also gets its own copy of the icon, to avoid
  having to track the last user before deleting it;
* `unintegrate` deletes all icons and desktop files belonging to the
  viewers. The deletion is done by name matching, so it will also clear
  entries for versions that have been uninstalled.

Currently, there is no way to integrate or unintegrate specific
versions, but calling:

```sh
asdf tigervnc-java-viewer unintegrate
asdf tigervnc-java-viewer integrate
```

will always resync things according to the installed versions and should
always be run after an install or an uninstall, if integration is used
at all.

## TL;DR

```sh
asdf plugin add tigervnc-java-viewer https://github.com/binary-manu/asdf-tigervnc-java-viewer.git
asdf install tigervnc-java-viewer latest
# Optional, for desktop integration
asdf tigervnc-java-viewer integrate
```


<!-- vi: set tw=72 et sw=2 fo=tcroqan autoindent: -->
