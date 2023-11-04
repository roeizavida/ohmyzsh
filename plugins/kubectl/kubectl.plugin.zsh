if (( ! $+commands[kubectl] )); then
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `kubectl`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubectl" ]]; then
  typeset -g -A _comps
  autoload -Uz _kubectl
  _comps[kubectl]=_kubectl
fi

kubectl completion zsh 2> /dev/null >| "$ZSH_CACHE_DIR/completions/_kubectl" &|

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
alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'

# Apply a YML file
alias kaf='kubectl apply -f'

# Drop into an interactive terminal on a container
alias keti='kubectl exec -t -i'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'

# List all contexts
alias kcgc='kubectl config get-contexts'

# General aliases
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kg='kubectl get'
alias kd='kubectl describe'
alias ke='kubectl edit'
alias kp='kubectl patch'
alias ks='kubectl scale'
alias kr='kubectl replace'
alias kro='kubectl rollout'
alias koj='kubectl -o json'
alias koy='kubectl -o yaml'

# Pod management.
alias kgp='kubectl get pod'
alias kgpa='kubectl get pod --all-namespaces'
alias kgpw='kubectl get pod --watch'
alias kgpaw='kubectl get pod --all-namespaces --watch'
alias kgpwide='kubectl get pod -o wide'
alias kgpawide='kubectl get pod --all-namespaces -o wide'
alias kep='kubectl edit pod'
alias kdp='kubectl describe pod'
alias kdelp='kubectl delete pod'
alias kgpi='kubectl get pod --output=custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,STATUS:.status.phase,AGE:.status.startTime,IMAGE:.spec.containers[*].image"'

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kubectl get pod -l'
alias kgpal='kubectl get pod --all-namespaces -l'

# get pod by namespace: kgpn kube-system"
alias kgpn='kubectl get pod -n'

# Service management.
alias kgs='kubectl get service'
alias kgsa='kubectl get service --all-namespaces'
alias kgsw='kubectl get service --watch'
alias kgsaw='kubectl get service --all-namespaces --watch'
alias kgswide='kubectl get service -o wide'
alias kgsawide='kubectl get service --all-namespaces -o wide'
alias kes='kubectl edit service'
alias kds='kubectl describe service'
alias kdels='kubectl delete service'

# Ingress management
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context --current --namespace'

# ConfigMap management
alias kgcm='kubectl get configmap'
alias kgcma='kubectl get configmap --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgsecd='get_k8s_secret'
alias kgseca='kubectl get secret --all-namespaces'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdw='kubectl get deployment --watch'
alias kgdaw='kubectl get deployment --all-namespaces --watch'
alias kgdwide='kubectl get deployment -o wide'
alias kgdawide='kubectl get deployment --all-namespaces -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'
alias kgdi='kubectl get deployment --output=custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,IMAGE:.spec.template.spec.containers[*].image"'
kres(){
    kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

# ReplicaSet Management
alias kgrs='kubectl get replicaset'
alias kgrsa='kubectl get replicaset --all-namespaces'
alias kdrs='kubectl describe replicaset'
alias kers='kubectl edit replicaset'

# Rollout management.
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'
alias krrd='kubectl rollout restart deployment'
alias krrss='kubectl rollout restart statefulset'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias kgssw='kubectl get statefulset --watch'
alias kgssaw='kubectl get statefulset --all-namespaces --watch'
alias kgsswide='kubectl get statefulset -o wide'
alias kgssawide='kubectl get statefulset --all-namespaces -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'
alias kgssi='kubectl get statefulset --output=custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,IMAGE:.spec.template.spec.containers[*].image"'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'

# Logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klfa='kubectl logs -f --all-containers'
alias klf1h='kubectl logs -f --since 1h'
alias klf1m='kubectl logs -f --since 1m'
alias klf1s='kubectl logs -f --since 1s'

# File copy
alias kcp='kubectl cp'

# Node Management
alias kgno='kubectl get nodes'
alias kgnowide='kubectl get nodes -o wide'
alias kgnow='kubectl get nodes --watch'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'

# PV management.
alias kgpv='kubectl get pv'
alias kgpva='kubectl get pv --all-namespaces'
alias kgpvw='kubectl get pv --watch'
alias kgpvaw='kubectl get pv --all-namespaces --watch'
alias kepv='kubectl edit pv'
alias kdpv='kubectl describe pv'
alias kdelpv='kubectl delete pv'


# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kubectl get pvc --watch'
alias kgpvcaw='kubectl get pvc --all-namespaces --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'

# PV management.
alias kgpv='kubectl get pv'
alias kgpva='kubectl get pv --all-namespaces'

# Service account management.
alias kdsa="kubectl describe serviceaccount"
alias kdelsa="kubectl delete serviceaccount"

# DaemonSet management.
alias kgds='kubectl get daemonset'
alias kgdsw='kubectl get daemonset --watch'
alias kgdsa='kubectl get daemonset --all-namespaces'
alias keds='kubectl edit daemonset'
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'

# CronJob management.
alias kgcj='kubectl get cronjob'
alias kecj='kubectl edit cronjob'
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'

# Job management.
alias kgj='kubectl get job'
alias kej='kubectl edit job'
alias kdj='kubectl describe job'
alias kdelj='kubectl delete job'

# Knative management.
alias kgksi='kubectl get ksvc --output=custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,READY:.status.conditions[?(@.type==\"Ready\")].status,URL:.status.url,IMAGE:.spec.template.spec.containers[*].image,LATESTCREATED:.status.latestCreatedRevisionName,LATESTREADY:.status.latestReadyRevisionName"'

# Delete all resources (run as "kdela --context <CONTEXT> -n <NAMESPACE> -l <KEY=VALUE>")
alias kdela='kubectl delete configmap,secret,deployment,statefulset,daemonset,service,ingress,job,cronjob,pod,replicaset'
alias kdelapurge='kubectl delete configmap,secret,deployment,statefulset,daemonset,service,ingress,job,cronjob,pod,replicaset,persistentvolumeclaim'

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
# cat ~/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh | grep -E "^alias kg" | grep -E -v 'output|wide|watch|get_k8s_secret' | sed -e 's/alias kg/alias kjg/g' -e "s/='kubectl/='kj/g" > ~/.oh-my-zsh/plugins/kubectl/kj_aliases.zsh
# cat ~/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh | grep -E "^alias kg" | grep -E -v 'output|wide|watch|get_k8s_secret' | sed -e 's/alias kg/alias kjxg/g' -e "s/='kubectl/='kjx/g" > ~/.oh-my-zsh/plugins/kubectl/kjx_aliases.zsh
# cat ~/.oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh | grep -E "^alias kg" | grep -E -v 'output|wide|watch|get_k8s_secret' | sed -e 's/alias kg/alias kyg/g' -e "s/='kubectl/='ky/g" > ~/.oh-my-zsh/plugins/kubectl/ky_aliases.zsh