###############################################
# Configs
###############################################
# Get git configs repo path
git_configs_path=$(find ~/git -type d -name 'configs')

# Set config aliases
alias sync-conf="python3 $git_configs_path/scripts/config.py sync"
alias fetch-conf="python3 $git_configs_path/scripts/config.py fetch"

# Load Aliases
source ~/.oh-my-zsh/roei/aliases.zsh
###############################################