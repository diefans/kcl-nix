# kcl-nix

There are three derivations, which depend on each other:

1. [kclvm](https://github.com/kcl-lang/kcl/tree/main/kclvm)

2. [kclvm_cli](https://github.com/kcl-lang/kcl/tree/main/cli)

3. [kcl](https://github.com/kcl-lang/cli)

```bash
# build
nix-build kcl.nix

# install
nix-env -if kcl.nix
```

## Notes

- kclvm containes weird overrides for the `PROTOC` environment variable, which
took me a lot of time to realize.

- nixos-23.11 packages are used, since I got error with `glibc` on
  nixos-unstable
