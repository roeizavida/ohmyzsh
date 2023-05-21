###############################################
# Variables
###############################################
# Get the plugin dir
plugin_dir=$(dirname $0)

# Get the OS
os_name=$(uname)
###############################################

###############################################
# ZSH
###############################################
# Disable ZSH update prompt
export DISABLE_UPDATE_PROMPT=true

# History
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTDIR=~/.zsh/history
mkdir -p $HISTDIR
export HISTFILE="${HISTDIR}/$(date +'%Y')"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
###############################################

###############################################
# Python
###############################################
export PYTHON_SITE_USER_BASE="$(python -m site --user-base)/bin"
export PATH="${PYTHON_SITE_USER_BASE}:$PATH"
###############################################

###############################################
# Rancher Desktop
###############################################
export PATH="$PATH:$HOME/.rd/bin"
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
