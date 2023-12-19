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
- Inherits exported env variables of root process.
- Does not inherit env variables of other `.local.bashrc` directories.

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

```
$ cd projects/bashrc/
dotlocaldotbashrc: open /home/ant/projects/bashrc
$ cd nested/
dotlocaldotbashrc: exit /home/ant/projects/bashrc
dotlocaldotbashrc: open /home/ant/projects/bashrc/nested
$ cd
dotlocaldotbashrc: exit /home/ant/projects/bashrc/nested
$
```

> Notice that navigating to the home directory resulted in only a bashrc bash
> session being exited. We just use the initial bash process that was started
> when bashrc and the rest of the interactive shell was bootstrapped.

You can source the local .local.bashrc at anytime with `dotlocaldotbashrc` function.

```bash
$ dotlocaldotbashrc
bashrc: source '/home/ant/.local.bashrc'
$
```

## Test

How to run the tests:

```bash
SPAT_SHELL='bash' spat ./dotlocaldotbashrc.t
```

> Uses [spat](https://github.com/bas080/spat) to run expect tests.

## License

GPLv3
