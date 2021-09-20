###############################################
# Variables
###############################################
# Get the plugin dir
plugin_dir=$(dirname $0)

# Get the OS
os_name=$(uname)
###############################################

###############################################
# Aliases
###############################################
# Load aliases
source "${plugin_dir}/aliases.zsh"

# Load os specific aliases
if [[ $os_name == "Darwin" ]]
then
  # Mac Aliases
  source "${plugin_dir}/mac_aliases.zsh"
elif [[ $os_name == "Linux" ]] && [[ -f "/usr/bin/lsb_release" ]]
then
  # Get the OS dist
  os_dist=$(lsb_release -is)
  if [[ $os_dist == "Ubuntu" ]]
  then
    # Ubuntu Aliases
    source "${plugin_dir}/ubuntu_aliases.zsh"
  fi
fi

# Load functions
source "${plugin_dir}/functions.zsh"
###############################################

###############################################
# Completion
###############################################
# Load zsh completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
###############################################

###############################################
# ZSH
###############################################
# Disable ZSH update prompt
DISABLE_UPDATE_PROMPT=true
###############################################
