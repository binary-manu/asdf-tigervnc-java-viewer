# An `asdf` plugin that manages TigerVNC Java Viewer versions

[![Test](https://github.com/binary-manu/asdf-tigervnc-java-viewer/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/binary-manu/asdf-tigervnc-java-viewer/actions/workflows/build.yml)

This plugin extends `asdf` with the ability to manage versions of the
TigerVNC Java Viewer, released upstream as jar files.

## Usage

For each jar version, the plugin will download it, then create a `bin`
folder with a shell script named `vncviewer` (this was named `tigervnc`
in `v0.1.x`) that wraps a call to the jar file, passing it any
additional parameters. This wrapper will be automatically picked by
`asdf` and added to the shims.

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
  having to track the last user before deleting it. Since v0.1.2, it is
  also possible to specify a version to integrate:

  ```sh
  # Integrate all installed versions
  asdf tigervnc-java-viewer integrate
  # Integrate just 1.2.3
  asdf tigervnc-java-viewer integrate 1.2.3
  ```

  Desktop integration is idemptotent: calling the command multiple times
  simply recreates identical files.

* `unintegrate` deletes all icons and desktop files belonging to the
  viewers. The deletion is done by name matching, so it will also clear
  entries for versions that have been uninstalled. Since v0.1.2, it is
  also possible to specify a version to unintegrate:

  ```sh
  # Unintegrate all versions and clean potential leftovers
  asdf tigervnc-java-viewer unintegrate
  # Unintegrate just 1.2.3
  asdf tigervnc-java-viewer unintegrate 1.2.3
  ```

Since v0.1.2, uninstalling a version, or removing the plugin, will
automatically remove the corresponding desktop entries.

## TigerVNC hosting vs plugin versions

### `v0.1.x`

All TigerVNC Java Viewer versions are grabbed from BinTray. This service
has been deprecated and will be shut down, with the deadline being May
1st 2021.  After that date you must upgrade to at least `v0.2.0` to be
able to download files.

### `v0.2.x`

After BinTray retirement, but before the TigerVNC developers decided
where to store releases, GitHub user _accetto_ stepped up and created a
[distribution mirror][accetto-tigervnc] to host a subset of the TigerVNC
binaries, The `v0.2.x` branch of this plugin uses this repository to
fetch the viewer.

This will limit the available versions to what is available in that
repo.  Currently, this means `v1.8.0` and above.

### `v0.3.x`

[SourceForge][sf-releases] is the new official home of TigerVNC
artifacts, and it includes all versions that were available at BinTray.

## TL;DR

```sh
asdf plugin add tigervnc-java-viewer https://github.com/binary-manu/asdf-tigervnc-java-viewer.git
asdf install tigervnc-java-viewer latest
# Optional, for desktop integration
asdf tigervnc-java-viewer integrate
```

[accetto-tigervnc]: https://github.com/accetto/tigervnc
[bintray]: https://bintray.com 
[sf-releases]: https://sourceforge.net/projects/tigervnc/files/stable

<!-- vi: set tw=72 et sw=2 fo=tcroqan autoindent: -->
