# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.2] - 2021-04-05

### Added

* It is now possible to manage desktop integration on a per-version
  basis.
* Removing a specific version, or the whole plugin, cleans desktop
  integration. Closes #1.

## [0.1.1] - 2021-03-30

### Fixed

* Fix GTK icon cache update in desktop integration scripts.
* Fix GitHub/BinTray version mismatch by querying BinTray for versions.
* Handle versions whose download URLs are irregular (i.e. v1.3.1 lacks
  the version in the filename).

## [0.1.0] - 2021-03-28

### Added

* First release

<!-- vi: set tw=72 et sw=2 fo=tcroqan autoindent: -->
