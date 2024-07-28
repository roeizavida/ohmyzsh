#!/bin/zsh -x

# Completions path
ZSH_COMPLETIONS_PATH=$ZSH/completions

# Completion tools
tools=(
  "op" # 1Password CLI
  "nerdctl"
  "kubeshark"
  "kubedog"
  "tenv"
  "dapr"
)

# Download completions
wget --quiet -O ${ZSH_COMPLETIONS_PATH}/_az https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion # Azure CLI

# Generate completions
for tool in ${tools[@]}
do
  if [[ -e $commands[$tool] ]]; then
      $tool completion zsh > ${ZSH_COMPLETIONS_PATH}/_${tool}
  fi
done
