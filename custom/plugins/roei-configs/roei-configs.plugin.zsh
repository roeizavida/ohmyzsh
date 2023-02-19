###############################################
# Configs
###############################################
# Get git configs repo path
git_configs_path=~/git/configs

# Set config aliases
alias sync-conf="python3 $git_configs_path/scripts/config.py sync"
alias fetch-conf="python3 $git_configs_path/scripts/config.py fetch"

# Load Aliases
source ${ZSH}/roei/aliases.zsh
###############################################
