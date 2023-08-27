###############################################
# SSH Agent
eval "$(ssh-agent -s)" &> /dev/null
ssh-add --apple-load-keychain &> /dev/null
###############################################
