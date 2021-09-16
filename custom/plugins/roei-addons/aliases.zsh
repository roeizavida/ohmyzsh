###############################################
# Aliases
###############################################
# ZSH
alias zshedit='vim ~/.zshrc'

# Bat
alias b='bat --theme TwoDark'
alias byml='b -l yaml'
alias bjson='b -l json'

# ls
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
alias llh='ls -lh --color=auto'
alias llah='ls -lah --color=auto'

# Base64
alias b64='base64 -w0'
alias b64d='base64 --decode'

# GPG
alias gpge='gpg --encrypt --symmetric --cipher-algo AES256 --sign --armor -r'
alias gpgd='gpg --decrypt'
alias gpgs='gpg --sign'
alias gpgb='gpg --detach-sign'
alias gpgv='gpg --verify'

# 1Password
alias opsign='eval $(op signin my)'

# Lower/Upper
alias lower="tr '[:upper:]' '[:lower:]'"
alias upper="tr '[:lower:]' '[:upper:]'"

# PBCopy
alias pbc=pbcopy
alias pbp=pbpaste

# 7-Zip
alias 7ze='7z a -p -mx=9 -mhe -t7z' # Create encrypted 7z archive

# VeraCrypt
alias vcm='veracrypt -t -k "" --pim=0 --protect-hidden=no'

# Curl
alias curls='curl -sL'

# Wget
alias wgetq='wget -q'

# Python3 Venv
alias vpy='./.venv/bin/python3'
alias vpip='./.venv/bin/pip3'
alias vpyactivate='source ./.venv/bin/activate'