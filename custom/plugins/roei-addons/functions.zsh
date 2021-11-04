###############################################
# Functions
###############################################
function dates () { # Get the exact date from "date +%s" output
    date --date="@$1"
}

function openssl_encrypt () {
    openssl aes-256-cbc -e -in "$1" -out "$1.aes"
}

function openssl_decrypt () {
    openssl aes-256-cbc -d -in "$1" -out "${1%.*}"
}

function tolower () {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

function toupper () {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

function tolower_pbc () {
    tolower "$1" | tr -d '\n' | pbcopy
}

function toupper_pbc () {
    toupper "$1" | tr -d '\n' | pbcopy
}

function git_prune () {
  # Prune local Git branches that does not exist on the remote
  git fetch --prune
  prune_branches=$(git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}')
  if [[ ! -z ${prune_branches} ]]
  then
    echo ${prune_branches} | xargs -n1 git branch -D
  fi
}

function docker_env () {
  docker inspect $1 | jq '.[].Config.Env'
}

function gitconfig () {
    pwd=$(pwd)
    gitconfigparams=$(realpath .gitconfigparams)
    for repo in $(find . -type f -wholename '*/.git/config' | grep -v -E '/.terraform/|/temp/' | awk -F '/.git/' '{print $1}')
    do
        cd ${pwd}/${repo}
        source ${gitconfigparams}
    done
    cd ${pwd}
}
