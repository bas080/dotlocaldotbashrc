#!/usr/bin/env zsh

EDITOR="cat"

{
source ./dotlocaldotzshrc

rm -r /tmp/dotlocaldotzshrc/test || true
mkdir -p /tmp/dotlocaldotzshrc/test/subdirectory
cd /tmp/dotlocaldotzshrc/test || exit

# Test Case 1: Initialize a new .local.zshrc
dotlocaldotzshrc init

# Validate that the .local.zshrc file has been created
test -f .local.zshrc

# Test Case 2: Attempt to initialize .local.zshrc again (expecting an error)
dotlocaldotzshrc init

echo 'echo hello .local.zshrc' >> .local.zshrc

# Test Case 3: Source the .local.zshrc file
dotlocaldotzshrc

# Test Case 4: Navigate to a subdirectory and source .local.zshrc
cd subdirectory

dotlocaldotzshrc

# Test Case 5: Exit the .local.zshrc session
cd ../../

_zshrc_init

dotlocaldotzshrc
} 2>&1 | sed "s#$PWD#/#g"
