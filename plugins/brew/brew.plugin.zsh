###############################################
# Aliases
###############################################
alias brewp='brew pin'
alias brews='brew list -1'
alias brewsp='brew list --pinned'
alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'
alias buf='brew upgrade --formula'
alias bcubo='brew update && brew outdated --cask'
alias bcubc='brew upgrade --cask && brew cleanup'

###############################################
# Homebrew Path
###############################################
PATH="/usr/local/sbin:$PATH"
###############################################