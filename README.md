## home-manager dotfiles

Managing my dotfiles using Nix
[home-manager](https://github.com/nix-community/home-manager).

### Installation

- Install [Nix](https://nixos.org/download.html#download-nix)
- Install [Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
- Clone repository
- Symlink repository to `~/.config/nixpkgs/`
- Run `home-manager switch`

Alternatively, run `./install.sh`

### Yubikey

We will need the package `scdaemon` that provides smart card support for GPG.

### Pen tablet

`https://driverdl.huion.com/driver/Linux/HuionTablet_v15.0.0.80.202204090856.x86_64.deb`

### Secrets

Secrets are stored in a `secrets.nix` file that does not get checked in. It
should contain variables that will be used by various configurations.

### TODO

- [ ] Alternate package sets based on host
