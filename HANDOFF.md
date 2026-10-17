# Handoff: Ghostty setup and guided tour

Read this first in a new Claude Code session, then pick up at "Next".

## Goal

Set up Ghostty and work through a guided tour of the basics, one stop at a
time, with the user trying each exercise.

## State

- Ghostty 1.3.1, classic snap, installed by `ubuntu/apt_install_terminal.sh`.
- Config: `dotfiles/ghostty/.config/ghostty/config.ghostty`, stowed to
  `~/.config/ghostty/config.ghostty` by `dotfiles/stow.sh`. Validates with
  `ghostty +validate-config`.
  - `font-family = Noto Sans Mono`, `font-size = 11`.
  - Theme line commented out (Ghostty default colors).
  - Alt+arrows move between splits.
- Tour: `ubuntu/ghostty_tour.md`, five stops with key tables and exercises.
  Keys come from `ghostty +list-keybinds --default`.
- Stop 1 (windows, tabs, splits) is done. Covered: opening the config
  (`Ctrl+,`), reloading (`Ctrl+Shift+,`), next/prev tab (`Ctrl+Tab` /
  `Ctrl+Shift+Tab`).

## Next

1. On a new machine: `sudo ubuntu/apt_install_terminal.sh`, then
   `dotfiles/stow.sh`.
2. Continue the tour at stop 2 (scrollback, search, copy). Present one stop,
   let the user try it, then move on.
3. Stops 2-5 have not been tried yet. Fix the tour if a key or behavior
   differs.

## Open choices for the user

- Add `shell-integration-features = ssh-terminfo,ssh-env` so remote hosts
  get the `xterm-ghostty` terminfo on first ssh.
- Make Ghostty the default terminal; `x-terminal-emulator` points to
  Terminator.
- Unbind Ghostty's Ctrl+Alt+arrow split keys, which GNOME takes first.
- Re-enable the theme, or pick another with `ghostty +list-themes`.
