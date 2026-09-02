# homebrew-splitr

Homebrew tap for [SplitR](https://github.com/tasticolly/splitr), an sshuttle
tunnel manager for macOS that keeps a pf kill switch loaded at all times.

```bash
brew install tasticolly/splitr/splitr
sudo splitr install
```

`splitr install` is the part that needs root: it writes the config, adds the
anchor call to `/etc/pf.conf` and starts the LaunchDaemon. Run `splitr doctor`
afterwards to check the result.
