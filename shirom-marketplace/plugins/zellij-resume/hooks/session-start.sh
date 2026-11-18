#!/usr/bin/env bash

[ -n "${ZELLIJ-}" ] && [ -n "${ZELLIJ_PANE_ID-}" ] || exit 0
command -v zellij >/dev/null 2>&1 || exit 0

event=$(cat) || exit 1
# shortcut: hooks emit plain UUIDs, use a JSON parser if that format changes.
session_pattern='"session_id"[[:space:]]*:[[:space:]]*"([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})"'
[[ "$event" =~ $session_pattern ]] || {
    printf 'Zellij: %s startup hook did not receive a session UUID\n' "$1" >&2
    exit 1
}
zellij action set-resurrect-command --pane-id "$ZELLIJ_PANE_ID" --cwd "$PWD" -- \
    bash -c '"$@"; "${SHELL:-/bin/bash}"; zellij action close-pane --pane-id "$ZELLIJ_PANE_ID"' zellij-resume \
    "$@" "${BASH_REMATCH[1]}" >/dev/null || exit 1
