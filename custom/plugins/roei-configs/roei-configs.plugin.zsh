###############################################
# Configs
###############################################
# Get git configs repo path
git_configs_path=~/git/configs

# Set config aliases
alias sync-conf="uv --directory $git_configs_path run python scripts/config.py sync"
alias fetch-conf="uv --directory $git_configs_path run python scripts/config.py fetch"

# Load Aliases
source ${ZSH}/roei/aliases.zsh
###############################################
