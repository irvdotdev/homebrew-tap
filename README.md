# bohselecta for Homebrew

Local model advice and a terminal chooser inside Claude Code.

```sh
brew install irvdotdev/tap/bohselecta
bohselecta native refresh claude
bohselecta setup claude
```

Answer **yes**, open a new terminal in your project folder, and type `claude`.

Homebrew installs Node and tmux. Sign in to Claude Code separately. The popup is prebuilt; no Rust is required. Supports macOS 15+ on Apple Silicon/Intel and compatible glibc Linux on arm64/x64.

Setup optionally adds a backed-up shell shortcut for zsh or bash. Plain interactive `claude` opens the chooser; commands with arguments, such as `claude --resume`, use ordinary Claude. Skip setup and use `bohselecta popup claude` directly if you prefer.

- Check setup: `bohselecta default claude status`.
- Undo: `bohselecta default claude off`, then open a new terminal.
- Update: `brew update && brew upgrade bohselecta`.
- Remove: undo the shortcut first, then `brew uninstall bohselecta`. Task history is retained.

[Website](https://irvdotdev.github.io/bohselecta/) · [Project](https://github.com/irvdotdev/bohselecta) · [Documentation](https://github.com/irvdotdev/bohselecta/blob/main/docs/README.md)

The update workflow checks hourly for a released formula, verifies its SHA-256 checksum, and commits it here. Release source and popup binaries are individually pinned by checksum in the formula. Formula installation and offline routing are tested on macOS and Linux.
