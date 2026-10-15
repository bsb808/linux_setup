# Editor for Claude Code (plan review, Ctrl+G) and git.
# --wait blocks until the file is closed; without it the VS Code launcher
# returns at once and its output garbles Claude Code's screen.
# No display (SSH, console): fall back to a terminal editor.
if [ -n "$DISPLAY$WAYLAND_DISPLAY" ] && command -v code >/dev/null; then
    export VISUAL="code --wait"
else
    export VISUAL=nano
fi
export EDITOR="$VISUAL"
