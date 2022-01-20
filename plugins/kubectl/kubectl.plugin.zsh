if (( $+commands[kubectl] )); then
  # TODO: 2022-01-05: remove this block
  # remove old generated files
  command rm -f "$ZSH_CACHE_DIR/kubectl_completion"

  # TODO: 2022-01-05: remove this bit of code as it exists in oh-my-zsh.sh
  # Add completions folder in $ZSH_CACHE_DIR
  command mkdir -p "$ZSH_CACHE_DIR/completions"
  (( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

  # If the completion file does not exist, generate it and then source it
  # Otherwise, source it and regenerate in the background
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubectl" ]]; then
    kubectl completion zsh >| "$ZSH_CACHE_DIR/completions/_kubectl"
    source "$ZSH_CACHE_DIR/completions/_kubectl"
  else
    source "$ZSH_CACHE_DIR/completions/_kubectl"
    kubectl completion zsh >| "$ZSH_CACHE_DIR/completions/_kubectl" &|
  fi
fi

function get_k8s_secret()
{
    secret=$1
    namespace=$2
    if [ -z "$namespace" ]
    then
        kubectl get secret $secret -o json | jq .data | jq -r 'to_entries[] | "\(.key): \(.value | @base64d)\n"'
    else
        kubectl get secret $secret -n $namespace -o json | jq .data | jq -r 'to_entries[] | "\(.key): \(.value | @base64d)\n"'
    fi
}

function k8s_yaml_to_json()
{
    kubectl create --dry-run=client -o json -f $1 | \
    jq -s '{kind: "List", apiVersion: "v1", metadata: {}, items: .}' | \
    jq "del(
        .items[].status,
        .items[].metadata.annotations.\"deployment.kubernetes.io/revision\",
        .items[].metadata.annotations.\"kubectl.kubernetes.io/last-applied-configuration\",
        .items[].metadata.annotations.\"field.cattle.io/publicEndpoints\",
        .items[].metadata.creationTimestamp,
        .items[].metadata.resourceVersion,
        .items[].metadata.selfLink,
        .items[].metadata.uid,
        .items[].metadata.generation,
        .items[].spec.template.metadata.creationTimestamp)"
}

# This command is used a LOT both below and in daily life
alias k=kubectl

# Kubectx
alias ktx=kubectx
alias kns=kubens

# Execute a kubectl command against all namespaces
alias kca='_kca(){ k "$@" --all-namespaces;  unset -f _kca; }; _kca'

# Apply a YML file
alias kaf='k apply -f'

# Drop into an interactive terminal on a container
alias keti='k exec -ti'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='k config use-context'
alias kcsc='k config set-context'
alias kcdc='k config delete-context'
alias kccc='k config current-context'

# List all contexts
alias kcgc='k config get-contexts'

# General aliases
alias kdel='k delete'
alias kdelf='kdel -f'
alias kg='k get'
alias kd='k describe'
alias ke='k edit'
alias kp='k patch'
alias ks='k scale'
alias kr='k replace'
alias kro='k rollout'

# Pod management.
alias kgp='k get pods'
alias kgpa='kgp --all-namespaces'
alias kgpw='kgp --watch'
alias kgpaw='kgpa --watch'
alias kgpwide='kgp -o wide'
alias kgpawide='kgpa -o wide'
alias kep='ke pods'
alias kdp='kd pods'
alias kdelp='kdel pods'
alias kgpi='kgp --output=custom-columns="NAME:.metadata.name,STATUS:.status.phase,AGE:.status.startTime,IMAGE:.spec.containers[*].image"'

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'
alias kgpal='kgpa -l'

# get pod by namespace: kgpn kube-system"
alias kgpn='kgp -n'

# Service management.
alias kgs='k get svc'
alias kgsa='kgs --all-namespaces'
alias kgsw='kgs --watch'
alias kgsaw='kgsa --watch'
alias kgswide='kgs -o wide'
alias kgsawide='kgsa -o wide'
alias kes='ke svc'
alias kds='kd svc'
alias kdels='kdel svc'

# Ingress management
alias kgi='k get ingress'
alias kgia='kgi --all-namespaces'
alias kei='ke ingress'
alias kdi='kd ingress'
alias kdeli='kdel ingress'

# Namespace management
alias kgns='k get namespaces'
alias kens='ke namespace'
alias kdns='kd namespace'
alias kdelns='kdel namespace'
alias kcn='kcsc --current --namespace'

# ConfigMap management
alias kgcm='k get configmaps'
alias kgcma='kgcm --all-namespaces'
alias kecm='ke configmap'
alias kdcm='kd configmap'
alias kdelcm='kdel configmap'

# Secret management
alias kgsec='k get secret'
alias kgsecd='get_k8s_secret'
alias kgseca='kgsec --all-namespaces'
alias kdsec='kd secret'
alias kdelsec='kdel secret'

# Deployment management.
alias kgd='k get deployment'
alias kgda='kgd --all-namespaces'
alias kgdw='kgd --watch'
alias kgdaw='kgda --watch'
alias kgdwide='kgd -o wide'
alias kgdawide='kgda -o wide'
alias ked='ke deployment'
alias kdd='kd deployment'
alias kdeld='kdel deployment'
alias ksd='ks deployment'
alias krsd='kro status deployment'
alias kgdi='k get deploy --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.template.spec.containers[*].image"'
kres(){
    kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

# Rollout management.
alias kgrs='k get rs'
alias kgrsa='kgrs --all-namespaces'
alias krh='kro history'
alias kru='kro undo'
alias krrd='kro restart deployment'
alias krrss='kro restart statefulset'

# Statefulset management.
alias kgss='k get statefulset'
alias kgssa='kgss --all-namespaces'
alias kgssw='kgss --watch'
alias kgssaw='kgssa --watch'
alias kgsswide='kgss -o wide'
alias kgssawide='kgssa -o wide'
alias kess='ke statefulset'
alias kdss='kd statefulset'
alias kdelss='kdel statefulset'
alias ksss='k scale statefulset'
alias krsss='kro status statefulset'
alias kgssi='kgss --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.template.spec.containers[*].image"'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kga='k get all'
alias kgaa='kga --all-namespaces'

# Logs
alias kl='k logs'
alias kl1h='kl --since 1h'
alias kl1m='kl --since 1m'
alias kl1s='kl --since 1s'
alias klf='kl -f'
alias klfa='klf --all-containers'
alias klf1h='klf --since 1h'
alias klf1m='klf --since 1m'
alias klf1s='klf --since 1s'

# File copy
alias kcp='k cp'

# Node Management
alias kgno='k get nodes'
alias kgnowide='kgno -o wide'
alias kgnow='kgno --watch'
alias keno='ke node'
alias kdno='kd node'
alias kdelno='kdel node'

# PV management.
alias kgpv='k get pv'
alias kgpva='kgpv --all-namespaces'
alias kgpvw='kgpv --watch'
alias kgpvaw='kgpva --watch'
alias kepv='ke pv'
alias kdpv='kd pv'
alias kdelpv='kdel pv'


# PVC management.
alias kgpvc='k get pvc'
alias kgpvca='kgpvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kgpvcaw='kgpvca --watch'
alias kepvc='ke pvc'
alias kdpvc='kd pvc'
alias kdelpvc='kdel pvc'

# PV management.
alias kgpv='k get pv'
alias kgpva='kgpv -A'

# Service account management.
alias kdsa="kd sa"
alias kdelsa="kdel sa"

# DaemonSet management.
alias kgds='k get daemonset'
alias kgdsw='kgds --watch'
alias keds='ke daemonset'
alias kdds='kd daemonset'
alias kdelds='kdel daemonset'

# CronJob management.
alias kgcj='k get cronjob'
alias kecj='ke cronjob'
alias kdcj='kd cronjob'
alias kdelcj='kdel cronjob'

# Delete all resources (run as "kdela --context <CONTEXT> -n <NAMESPACE> -l <KEY=VALUE>")
alias kdela='kdel configmap,secret,deployment,statefulset,daemonset,service,ingress,job,cronjob,pod,replicaset'
alias kdelapurge='kdel configmap,secret,deployment,statefulset,daemonset,service,ingress,job,cronjob,pod,replicaset,persistentvolumeclaim'

###############################################
# KJ, KJX and KY syntax colors
###############################################
# Get the plugin dir
plugin_dir=$(dirname $0)

# Only run if the user actually has kubectl installed
if (( ${+_comps[kubectl]} )); then
  function kj() { kubectl "$@" -o json | jq; }
  function kjx() { kubectl "$@" -o json | fx; }
  function ky() { kubectl "$@" -o yaml | yh; }

  compdef kj=kubectl
  compdef kjx=kubectl
  compdef ky=kubectl
fi

# Load the syntax aliases
if (( $+commands[jq] )); then
    source "${plugin_dir}/kj_aliases.zsh"
fi
if (( $+commands[fx] )); then
    source "${plugin_dir}/kjx_aliases.zsh"
fi
if (( $+commands[yh] )); then
    source "${plugin_dir}/ky_aliases.zsh"
fi

# The syntax aliases files were created with:
# cat ~/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh | grep -E "^alias kg" | grep -E -v 'output|wide|watch|get_k8s_secret' | sed -e 's/alias kg/alias kjg/g' -e "s/='k/='kj/g" > ~/.oh-my-zsh/plugins/kubectl/kj_aliases.zsh
# cat ~/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh | grep -E "^alias kg" | grep -E -v 'output|wide|watch|get_k8s_secret' | sed -e 's/alias kg/alias kjxg/g' -e "s/='k/='kjx/g" > ~/.oh-my-zsh/plugins/kubectl/kjx_aliases.zsh
# cat ~/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh | grep -E "^alias kg" | grep -E -v 'output|wide|watch|get_k8s_secret' | sed -e 's/alias kg/alias kyg/g' -e "s/='k/='ky/g" > ~/.oh-my-zsh/plugins/kubectl/ky_aliases.zsh