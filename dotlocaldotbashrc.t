#!/usr/bin/env bash

set -x

EDITOR="cat"

source ./dotlocaldotbashrc

rm -r /tmp/dotlocaldotbashrc/test || true
mkdir -p /tmp/dotlocaldotbashrc/test/subdirectory
cd /tmp/dotlocaldotbashrc/test || exit

# Test Case 1: Initialize a new .local.bashrc
dotlocaldotbashrc init

# Validate that the .local.bashrc file has been created
test -f .local.bashrc

# Test Case 2: Attempt to initialize .local.bashrc again (expecting an error)
dotlocaldotbashrc init

echo 'echo hello .local.bashrc' >> .local.bashrc

# Test Case 3: Source the .local.bashrc file
dotlocaldotbashrc

# Test Case 4: Navigate to a subdirectory and source .local.bashrc
cd subdirectory

dotlocaldotbashrc

# Test Case 5: Exit the .local.bashrc session
cd ../../

_bashrc_init

dotlocaldotbashrc
