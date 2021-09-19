###############################################
# Configs
###############################################
# Get git configs repo path
git_configs_path=$(find ~/git -type d -name 'configs')

# Set config aliases
alias sync-conf="$git_configs_path/scripts/sync_config.sh"
alias fetch-conf="$git_configs_path/scripts/fetch_config.sh"

# Load Aliases
source ~/.oh-my-zsh/roei/aliases.zsh
###############################################