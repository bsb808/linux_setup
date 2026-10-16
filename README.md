# linux_setup

Setup scripts and notes for Linux installs, ROS and LCM.

## Layout

| Directory | Contents |
|---|---|
| `ubuntu/` | Ubuntu install scripts, newest release first; `ubuntu/older/` holds 14.04 through 20.04 |
| `generic/` | bash additions, emacs, terminator configs, project switcher |
| `dotfiles/` | stow packages symlinked into `$HOME`: Ghostty, tmux, bash snippets |
| `backup/` | rsync backup scripts for the workstation, NAS and external drives |
| `macos/` | bash and python setup notes for macOS |
| `mrc/`, `robotx_setup/`, `ros/` | project-specific fleet and ROS scripts |

## Current machines

Ubuntu 26.04 LTS on a ThinkPad X1 Carbon Gen 9 — travel and couch laptop.
Start at [`ubuntu/Ubuntu26_X1Carbon_Install.md`](ubuntu/Ubuntu26_X1Carbon_Install.md),
then run [`ubuntu/setup_26_x1.sh`](ubuntu/setup_26_x1.sh).

Earlier: [`ubuntu/Ubuntu24DesktopInstall.md`](ubuntu/Ubuntu24DesktopInstall.md) and the
`apt_install_24_*.sh` scripts, including `apt_install_24_x1.sh` for the first X1.

## First steps on a new machine

```bash
sudo apt install git
ssh-keygen -t ed25519 -C "briansbingham@gmail.com"   # upload to GitHub
git clone git@github.com:bsb808/linux_setup.git ~/WorkingCopies/linux_setup
cd ~/WorkingCopies/linux_setup/ubuntu
./setup_26_x1.sh
```

## Terminal and dotfiles

Ghostty, tmux and their config, kept in step across machines with GNU stow.

```bash
sudo ubuntu/apt_install_terminal.sh   # tmux, xclip, fzf, stow, Ghostty snap
dotfiles/stow.sh                      # symlink dotfiles/* into $HOME
```

Each directory under `dotfiles/` is a stow package that mirrors `$HOME`, so
`dotfiles/tmux/.tmux.conf` becomes `~/.tmux.conf`. The live files are symlinks
into this repo: edit them in place and commit. `stow.sh` moves any real file it
would replace to `~/.dotfiles-backup/<time>/`. To add a file, move it into a
package at the same relative path and re-run `dotfiles/stow.sh <package>`.

`~/.bashrc` itself stays machine-local. The `bash` package links `~/.bashrc.d/`,
and `stow.sh` adds one marked block to `~/.bashrc` that sources
`~/.bashrc.d/*.sh`, once. `editor.sh` there sets `VISUAL`/`EDITOR` to
`code --wait` (`nano` without a display), so Claude Code's external editor
doesn't garble its screen.

To leave a laptop running with the lid closed while plugged in (on battery it
still suspends), run `ubuntu/lid_awake_on_ac.sh` as your user; it uses sudo
for the logind drop-in.
