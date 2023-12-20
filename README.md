# 👇local👇bashrc

`.local.bashrc` files that are sourced in a clean bash process when entering
the directory.

*Replaces the [projector](https://github.com/bas080/projector) project.*

## Features

- Makes a simple to define env variables, aliases and functions for a specific
  project directory.
- Creates a bash history that is a separate from the root bash history.
  - Makes it easier to keep and find commands that are related to that project.
  - Doesn't fill up the root bash history.
- Does not inherit env variables of other `.local.bashrc` directories when
  jumping directories.

## Setup

A quick setup script.

```bash
curl 'https://raw.githubusercontent.com/bas080/dotlocaldotbashrc/master/dotlocaldotbashrc' > "$HOME/.dotlocaldotbashrc" &&
  echo 'source "$HOME/.dotlocaldotbashrc"' >> ~/.bashrc
```

After re-sourcing your .bashrc you can create a `.local.bashrc` in a directory where you would like
a local bashrc by running `dotlocaldotbashrc init`.

Optionally you can show which local bashrc is currently active in your prompt.

```bash
# What I use:
PS1="${BASHRC_HOME#$HOME/}:\W "

# Looks like this:
projects/dotlocaldotbashrc:dotlocaldotbashrc cd ../█
```

When using in repositores consider adding `.local.*` to your `.gitignore`.

## Usage

Quick start:

```text
USAGE:

  dotlocaldotbashrc [subcommand]

  Will re-source the local bashrc if no subcommand is provided.

  [subcommand]

    init - create a .local.bashrc in current directory.

    edit - opens the bashrc in $EDITOR and re-sources on exit.
```

More information:

```
$ cd projects/bashrc/
dotlocaldotbashrc: open /home/user/projects/bashrc
$ cd nested/
dotlocaldotbashrc: exit /home/user/projects/bashrc
dotlocaldotbashrc: open /home/user/projects/bashrc/nested
$ cd
dotlocaldotbashrc: exit /home/user/projects/bashrc/nested
$
```

> Notice that navigating to the home directory resulted in only a bashrc bash
> session being exited. We just use the initial bash process that was started
> when bashrc and the rest of the interactive shell was bootstrapped.

You can source the local .local.bashrc at anytime with `dotlocaldotbashrc` function.

```bash
$ dotlocaldotbashrc
bashrc: source '/home/user/.local.bashrc'
$
```

You can quickly edit and automatically source after editor quit with
`dotlocaldotbashrc edit`.

One notable feature of `dotlocaldotbashrc` is its behavior when background jobs
are active. When attempting to exit the `dotlocaldotbashrc` session using the
`cd` command or when explicitly running the `dotlocaldotbashrc` command with the
`exit` option, the script checks for any background jobs in the current session.

If there are background jobs running, the script will display an error message
and refrain from exiting the session. This behavior ensures that you don't
unintentionally lose work by exiting a session with active background jobs.

```bash
$ cd projects/myproject/
dotlocaldotbashrc: open /home/user/projects/myproject

# Start a background job
$ sleep 300 & # ctrl-z
[1] 12345

# Attempt to exit the dotlocaldotbashrc session
$ cd ..
dotlocaldotbashrc: error: will not exit with jobs in the background.
```

## Test

How to run the tests:

```bash
SPAT_SHELL='bash' spat ./dotlocaldotbashrc.t
```

> Uses [spat](https://github.com/bas080/spat) to run expect tests.

## License

GPLv3
