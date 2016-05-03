<img src="https://img.shields.io/badge/Sponsor-Detroit%20Labs-000000.svg" />

# Groom your Xcode environment with xcenv.

## Table Of Contents

* [How It Works](#how-it-works)
  * [Choosing the Xcode Version](#choosing-the-xcode-version)
* [Installation](#installation)
  * [Manual Installation](#manual_installation)

## How It Works

### Choosing the Xcode Version

When you execute a shim, xcenv determines which Xcode version to use by reading it from the following sources, in this order:

1. The first .xcode-version file found by searching the current working directory and each of its parent directories until reaching the root of your filesystem. You can modify the .ruby-version file in the current working directory with the xcenv local command.

2. The global ~/.xcenv/.xcode-version file. You can modify this file using the xcenv global command. If the global version file is not present, xcenv assumes you want to use the "system" Xcode—i.e. whatever is returned by xcode-select -p

## Installation

### Basic Git Installation

To install xcenv:

	$ git clone git@github.com:xcenv/xcenv.git ~/.xcenv

Copy the following into your shell profile file:

	export PATH="$HOME/.xcenv/bin:$PATH"
	eval "$(xcenv init -)"

## TODO

- [ ] Add XCODE_VERSION support
- [ ] Add support to search from location of the xcodeproj/xcworkspace
- [ ] Add more to README  
  - [ ] Add instructions for Development  
  - [ ] Add Environment Variables 
- [ ] Support Homebrew installation  
- [ ] Add autocomplete support
- [ ] Add Usage and Sumarry to all commands
- [ ] Add Unit Tests with [Bats](https://github.com/sstephenson/bats)
- [ ] Add Travis CI
- [ ] Add local command
- [ ] Add shell command
- [ ] Add global command
- [ ] Add shims command 
- [ ] Add version commands (name, path)