<!-- SPDX-License-Identifier: copyleft-next-0.3.1 -->

# qemu-system-generator-bootstrap

The files the bootstrap guides of
[qemu-system-generator](https://github.com/linux-kdevops/qemu-system-generator)
have a reader write, one commit per change a guide makes, so every diff
the guides show is a real one.

Each guide has a branch whose tree is laid out like the reader's home:
`bootstrap/<guide>/` holds the flake and its modules,
`.config/qemu/systemd/` the `.qemu` files and their drop-ins. A file
holds what the guide shows, `/home/user` and `ssh-ed25519 AAAA...
bootstrap` included. `packages` forks from `direct` at the step the
packages guide starts from; the other branches start from nothing.
`main` holds only this file and `guides`.

| Branch     | Guide                               |
|------------|-------------------------------------|
| `direct`   | `docs/bootstrap/direct.rst`         |
| `packages` | `docs/bootstrap/packages.rst`       |
| `disk`     | `docs/bootstrap/disk.rst`           |
| `uki`      | `docs/bootstrap/uki.rst`            |
| `knix`     | `docs/bootstrap/knix.rst`           |
| `cloud`    | `docs/bootstrap/cloud.rst`          |
| `nixos`    | `docs/bootstrap/nixos.rst`          |
| `example`  | `docs/getting-started/example.rst`  |

A diff block in a guide is what `./guides hunk REV PATH --indent 3`
prints for the commit that makes the change: git's output from the
`---` line on, with three lines of context. To change a step, rewrite
the branch from that commit on, paste the new hunks into the guide, and
check the guides against the branches:

```shell
./guides check /path/to/qemu-system-generator
```
