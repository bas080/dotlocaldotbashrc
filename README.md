# 👇local👇(bash|zsh)rc

`.local.bashrc`  or  `.local.zshrc` files that are sourced in a clean process when entering
the directory.

*Replaces the [projector](https://github.com/bas080/projector) project.*

## Features

- Makes a simple to define env variables, aliases and functions for a specific
  project directory.
- Creates a shell history that is a separate from the root shell history.
  - Makes it easier to keep and find commands that are related to that project.
  - Doesn't fill up the root shell history.
- Does not inherit env variables of other `.local.bashrc`/`.local.zshrc` directories when
  jumping directories.

## Setup

### Bash:

A quick setup script for bash.

```bash
curl 'https://raw.githubusercontent.com/brianmatzelle/dotlocaldotrc/refs/heads/master/bash/dotlocaldotbashrc' > "$HOME/.dotlocaldotbashrc" &&
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

When using in repositories consider adding `.local.*` to your `.gitignore`.

### Zsh:

A quick setup script for Z shell.

```zsh
curl 'https://raw.githubusercontent.com/brianmatzelle/dotlocaldotrc/refs/heads/master/zsh/dotlocaldotzshrc' > "$HOME/.dotlocaldotzshrc" &&
  echo 'source "$HOME/.dotlocaldotzshrc"' >> ~/.zshrc
```

After re-sourcing your .zshrc you can create a `.local.zshrc` in a directory where you would like
a local zshrc by running `dotlocaldotzshrc init`.

Optionally you can show which local zshrc is currently active in your prompt.

```zsh
# What I use:
PS1="${ZSHRC_HOME#$HOME/}:\W "

# Looks like this:
projects/dotlocaldotzshrc:dotlocaldotzshrc cd ../█
```

When using in repositories consider adding `.local.*` to your `.gitignore`.

## Usage

### Bash

Quick start:

```text
dotlocaldotbashrc [<subcommand>]
  Create and configure directory specific bash sessions.

  Will source .local.bashrc when no subcommand is defined.

  [subcommand]
    init - Create a .local.bashrc in current directory.
    edit - Opens the bashrc in $EDITOR and re-sources on exit.
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

### Zsh

Quick start:

```text
dotlocaldotzshrc [<subcommand>]
  Create and configure directory specific zsh sessions.

  Will source .local.zshrc when no subcommand is defined.

  [subcommand]
    init - Create a .local.zshrc in current directory.
    edit - Opens the zshrc in $EDITOR and re-sources on exit.
```

More information:

```
$ cd projects/zshrc/
dotlocaldotzshrc: open /home/user/projects/zshrc
$ cd nested/
dotlocaldotzshrc: exit /home/user/projects/zshrc
dotlocaldotzshrc: open /home/user/projects/zshrc/nested
$ cd
dotlocaldotzshrc: exit /home/user/projects/zshrc/nested
$
```

> Notice that navigating to the home directory resulted in only a zshrc zsh
> session being exited. We just use the initial zsh process that was started
> when zshrc and the rest of the interactive shell was bootstrapped.

You can source the local .local.zshrc at anytime with `dotlocaldotzshrc` function.

```zsh
$ dotlocaldotzshrc
zshrc: source '/home/user/.local.zshrc'
$
```

You can quickly edit and automatically source after editor quit with
`dotlocaldotzshrc edit`.

One notable feature of `dotlocaldotzshrc` is its behavior when background jobs
are active. When attempting to exit the `dotlocaldotzshrc` session using the
`cd` command or when explicitly running the `dotlocaldotzshrc` command with the
`exit` option, the script checks for any background jobs in the current session.

If there are background jobs running, the script will display an error message
and refrain from exiting the session. This behavior ensures that you don't
unintentionally lose work by exiting a session with active background jobs.

```zsh
$ cd projects/myproject/
dotlocaldotzshrc: open /home/user/projects/myproject

# Start a background job
$ sleep 300 & # ctrl-z
[1] 12345

# Attempt to exit the dotlocaldotzshrc session
$ cd ..
dotlocaldotzshrc: error: will not exit with jobs in the background.
```

## Test

How to run the tests:

### Bash

```bash
SPAT_SHELL='bash' spat ./dotlocaldotbashrc.t
```

### Zsh

```bash
SPAT_SHELL='zsh' spat ./dotlocaldotzshrc.t
```

Uses [spat](https://github.com/bas080/spat) to run expect tests.

## License

GPLv3
