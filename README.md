# bohselecta for Homebrew

```sh
brew install irvdotdev/tap/bohselecta
bohselecta native refresh claude
bohselecta popup claude
```

Homebrew installs Node and tmux. Sign in to Claude Code separately. The popup is prebuilt; no Rust is required. Supports macOS 15+ on Apple Silicon/Intel and compatible glibc Linux on arm64/x64.

Update with `brew update && brew upgrade bohselecta`. Remove with `brew uninstall bohselecta`; task history is retained.

[Project and installation alternatives](https://github.com/irvdotdev/bohselecta)

The update workflow checks hourly for a released formula, verifies its SHA-256 checksum, and commits it here. Release source and popup binaries are individually pinned by checksum in the formula. Formula installation and offline routing are tested on macOS and Linux.
