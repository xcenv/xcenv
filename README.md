<img src="https://img.shields.io/badge/Sponsor-Detroit%20Labs-000000.svg" />

# Groom your Xcode environment with xcenv.

## Table Of Contents

* [Installation](#installation)
  * [Manual Installation](#manual_installation)

## Installation

### Basic Git Installation

To install xcenv:

	$ git clone git@github.com:xcenv/xcenv.git ~/.xcenv

Copy the following into your shell profile file:

	export PATH="$HOME/.xcenv/bin:$PATH"
	eval "$(xcenv init -)"

## TODO

- [ ] Init command creates shims of xcode binaries in /usr/bin that contain "libxcselect.dylib"  
- [ ] Add more to README  
  - [ ] Add instructions for use  
  - [ ] Add instructions for Development  
  - [ ] Add How It Works section
  - [ ] Add Environment Variables 
- [ ] Support Homebrew installation  
- [ ] Add autocomplete support
- [ ] Add support for non-bash Shells
- [ ] Add Usage and Sumarry to all commands
- [ ] Add Unit Tests with [Bats](https://github.com/sstephenson/bats)
- [ ] Add Travis CI
- [ ] Add local command
- [ ] Add global command
- [ ] Add shims command 
- [ ] Add version commands (name, path)