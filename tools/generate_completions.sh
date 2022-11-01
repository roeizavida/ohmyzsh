#!/bin/bash

# Completions path
ZSH_COMPLETIONS_PATH=~/.oh-my-zsh/completions

# Completion commands
commands=(
  "op" # 1Password CLI
  "nerdctl"
)

# Download completions
wget --quiet -O ${ZSH_COMPLETIONS_PATH}/_az https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion # Azure CLI

# Generate completions
for command in ${commands[@]}
do
  $command completion zsh > ${ZSH_COMPLETIONS_PATH}/_${command}
done
