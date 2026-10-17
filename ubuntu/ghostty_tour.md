# Ghostty tour

A hands-on walk through Ghostty 1.3 on this machine. Keys are the defaults
from `ghostty +list-keybinds --default`, plus the Alt+arrow split bindings in
our config.

## Setup

- Installed as a classic snap by `ubuntu/apt_install_terminal.sh`.
- Config: `dotfiles/ghostty/.config/ghostty/config.ghostty`, stowed to
  `~/.config/ghostty/config.ghostty`. Edit the repo copy and commit.
- Font Noto Sans Mono 11. Theme line is commented out, so Ghostty's default
  colors apply; uncomment it to follow GNOME light/dark with Catppuccin.
- `TERM=xterm-ghostty`, which matches the `xterm*` features in `.tmux.conf`.

## 1. Windows, tabs, splits

| Do this | Keys |
|---|---|
| New window | `Ctrl+Shift+N` |
| New tab / jump to tab N / next / previous | `Ctrl+Shift+T` / `Alt+1`…`Alt+8` (`Alt+9` = last) / `Ctrl+Tab` / `Ctrl+Shift+Tab` |
| Split right / split down | `Ctrl+Shift+O` / `Ctrl+Shift+E` |
| Move between splits | `Alt+←→↑↓` |
| Zoom a split to full window and back | `Ctrl+Shift+Enter` |
| Resize a split | `Super+Ctrl+Shift+arrows` |
| Close split or tab | `Ctrl+Shift+W` (or `exit`) |
| Fullscreen | `Ctrl+Enter` |
| Command palette (every action, searchable) | `Ctrl+Shift+P` |

Exercise: split right, then split down, move with Alt+arrows, zoom one split,
then open the palette and type "split".

Ctrl+PgDn/PgUp and Ctrl+Shift+→/← also switch tabs.

## 2. Scrollback, search, copy

| Do this | Keys |
|---|---|
| Search scrollback / close search | `Ctrl+Shift+F` / `Esc` |
| Jump to previous / next prompt | `Ctrl+Shift+PgUp` / `Ctrl+Shift+PgDn` |
| Copy / paste | `Ctrl+Shift+C` / `Ctrl+Shift+V` |
| Paste the current selection | `Shift+Insert` or middle-click |
| Select all | `Ctrl+Shift+A` |
| Paste scrollback to a temp file path | `Ctrl+Shift+J` |
| Open scrollback in an editor | `Ctrl+Alt+Shift+J` |

- `copy-on-select` is on: selecting text puts it on the primary selection, so
  middle-click pastes it without copying.
- Double-click selects a word, triple-click selects a line.
- Ctrl+click opens URLs.

Exercise: run `ls -la /usr/bin`, search for `python`, jump back to the prompt
with Ctrl+Shift+PgUp, then press Ctrl+Shift+J and `less` the file it pastes.

## 3. Config, fonts, themes

| Do this | Keys / command |
|---|---|
| Open config in the default editor | `Ctrl+,` |
| Reload config (all windows) | `Ctrl+Shift+,` |
| Font size up / down / reset | `Ctrl+=` / `Ctrl+-` / `Ctrl+0` |
| Check config for errors | `ghostty +validate-config` |
| All options with docs | `ghostty +show-config --default --docs \| less` |
| Preview themes interactively | `ghostty +list-themes` |
| Font names Ghostty can use | `ghostty +list-fonts` |

- Save before reloading; Ghostty reads the file from disk.
- Most settings apply on reload. `font-family` and window padding may need a
  new tab or window.
- A bad line shows an error and the last working config stays active.
- Ctrl+=/- override the config size in that window until Ctrl+0.

Exercise: in `+list-themes`, browse a few themes, then change `font-size` in
the config, save, and reload.

## 4. Shell integration and tmux

Ghostty injects shell integration into bash automatically
(`shell-integration = detect`). It enables:

- prompt marks, which make Ctrl+Shift+PgUp/PgDn work
- cursor shape changes (bar at the prompt, block in programs)
- window and tab titles from the running command and working directory
- new tabs and splits opening in the current directory
- clicking on the prompt line to move the cursor there

Off by default: `ssh-terminfo` and `ssh-env`. Remote hosts don't know
`xterm-ghostty`, so turn these on to copy the terminfo across on first ssh:

```
shell-integration-features = ssh-terminfo,ssh-env
```

Ghostty and tmux overlap. Inside tmux, Ghostty search and prompt jumping see
only tmux's redrawn screen, not each pane's history. Use Ghostty splits and
tabs for local work, and tmux where sessions must survive a disconnect.

Exercise: open a split in a deep directory and check that the new split
starts there; watch the tab title change while `sleep 5` runs.

## 5. Inspector

`Ctrl+Shift+I` toggles the terminal inspector for the current split. It
shows:

- each key event and the escape sequence sent to the program
- the cell under the mouse: character, codepoint, colors, style
- the font actually used for each glyph
- terminal modes and the size in cells and pixels

Use it when a keybinding doesn't reach a program, or a glyph renders from a
fallback font.

Exercise: open the inspector, press Shift+Enter and Alt+←, and compare the
events shown.

## Open choices

- Make Ghostty the default terminal; `x-terminal-emulator` is still Terminator.
- Unbind Ghostty's Ctrl+Alt+arrow split keys, which GNOME takes first:
  `keybind = ctrl+alt+arrow_left=unbind` (and the other three).
