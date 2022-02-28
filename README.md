## home-manager dotfiles

Managing my dotfiles using Nix
[home-manager](https://github.com/nix-community/home-manager).

### Installation

- Install [Nix](https://nixos.org/download.html#download-nix)
- Install [Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
- Clone repository
- Symlink repository to `~/.config/nixpkgs/`
- Run `home-manager switch`

### Yubikey

We will need the package `scdaemon` that provides smart card support for GPG.

### TODO

- [ ] Alternate package sets based on host
- [ ] Secret management
