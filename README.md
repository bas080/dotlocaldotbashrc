# dotbashrc

Local `.bashrc` files that are sourced in a clean bash process.

## Features

- Makes a simple to define env variables, aliases and functions for a specific
  project directory.
- Creates an bash history that is a separate from the root bash history.
  - Makes it easier to keep and find commands that are related to that project.
  - Doesn't fill up the root bash history.
- Inherits exported env variables of root process.
- Does not inherit env variables of other .bashrc directories.

## Setup

Add the following to your `.bashrc`.

```bash
# Required
source "$HOME/.bashrc"

# Optional: show .bashrc directory name in prompt.
PS1="(bashrc:$BASHRC_HOME)$PS1"
```

## Usage

```
(bashrc:ant)$ cd projects/bashrc/
bashrc: open /home/ant/projects/bashrc
(bashrc:bashrc)$ cd nested/
bashrc: exit /home/ant/projects/bashrc
bashrc: open /home/ant/projects/bashrc/nested
(bashrc:bashrc)$ cd
bashrc: exit /home/ant/projects/bashrc/nested
(bashrc:bashrc)$
```

> Notice that navigating to the home directory resulted in only a bashrc bash
> session being exited. We just use the initial bash process that was started
> when bashrc and the rest of the interactive shell was bootstrapped.

## License

GPLv3
