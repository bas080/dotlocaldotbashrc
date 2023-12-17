#!/usr/bin/env bash

_bashrc_dir() {
  local dir="$1"

  test -f "$dir/.bashrc" && echo "$dir" && return 0
  test '/' = "$dir" && return 1

  _bashrc_dir "$(dirname "$1")"
}

BASHRC_HOME="$(_bashrc_dir "$PWD")"
BASHRC_HOME="${BASHRC_HOME:-$HOME}"
HISTFILE="$BASHRC_HOME/.bash_history"

test "$BASHRC_HOME" = "$HOME" || {
  source "$BASHRC_HOME/.bashrc"
}

bashrc () {
  echo "bashrc: source '$BASHRC_HOME/.bashrc'"
  source "$BASHRC_HOME/.bashrc"
}

_bashrc_init() {

  local bashrc_dir
  local bashrc_temp

  # Return early if no .bashrc is found.
  bashrc_dir="$(_bashrc_dir "$PWD")" || {
    # Exit the bash session if one is active.
    test -n "$BASHRC_TEMP" && {
      echo "$PWD" > "$BASHRC_TEMP"
      exit
    }
    # Otherwise just return.
    return
  }

  # The local bashrc path changed.
  test "$bashrc_dir" != "$BASHRC_HOME" && {

    # Current bash process is a local bashrc session.
    test -n "$BASHRC_TEMP" && {
      echo "$PWD" > "$BASHRC_TEMP"
      echo "bashrc: exit $BASHRC_HOME"
      exit
    }

    # Current bash process is the original (root) session.
    bashrc_temp="$(mktemp)"

    # Only start a local session if the bashrc dir is not the home directory.
    test "$bashrc_dir" = "$HOME" && return

    echo "bashrc: open $bashrc_dir"
    BASHRC_TEMP="$bashrc_temp" bash

    test -s "$bashrc_temp" || exit
    cd "$(cat "$bashrc_temp")" || true
    _bashrc_init

  }

}

PROMPT_COMMAND="_bashrc_init;$PROMPT_COMMAND"
