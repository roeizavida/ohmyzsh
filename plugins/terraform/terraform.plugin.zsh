###############################################
# Functions
###############################################
function tf_prompt_info() {
  # dont show 'default' workspace in home dir
  [[ "$PWD" != ~ ]] || return
  # check if in terraform dir and file exists
  [[ -d "${TF_DATA_DIR:-.terraform}" && -r "${TF_DATA_DIR:-.terraform}/environment" ]] || return

  local workspace="$(< "${TF_DATA_DIR:-.terraform}/environment")"
  echo "${ZSH_THEME_TF_PROMPT_PREFIX-[}${workspace:gs/%/%%}${ZSH_THEME_TF_PROMPT_SUFFIX-]}"
}

function tf_version_prompt_info() {
    local terraform_version
    terraform_version=$(terraform --version | head -n 1 | cut -d ' ' -f 2)
    echo "${ZSH_THEME_TF_VERSION_PROMPT_PREFIX-[}${terraform_version:gs/%/%%}${ZSH_THEME_TF_VERSION_PROMPT_SUFFIX-]}"
}

function tf_targets () {
    cat $1 | grep 'resource ".*"\|data ".*"\|module ".*"' | sed -e 's/ "/./g' -e 's/"././g' -e 's/.{//g' -e 's/^resource.//g' -e 's/^/-target /g' -e 's/$/ \\/g'
}

###############################################
# Terraform Cache
###############################################
export TF_PLUGIN_CACHE_DIR=~/.terraform_cache
mkdir -p $TF_PLUGIN_CACHE_DIR

###############################################
# Aliases
###############################################
alias tf='terraform'
alias tfinit='terraform init'
alias tfinitb='terraform init -backend-config'
alias tfv='terraform validate'
alias tfa='terraform apply'
alias tfav='terraform apply -var-file'
alias tfa!='terraform apply -auto-approve'
alias tfap='terraform apply -parallelism=1'
alias tfc='terraform console'
alias tfd='terraform destroy'
alias tfd!='terraform destroy -auto-approve'
alias tfdp='terraform destroy -parallelism=1'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'
alias tfi='terraform init'
alias tfir='terraform init -reconfigure'
alias tfiu='terraform init -upgrade'
alias tfiur='terraform init -upgrade -reconfigure'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfpv='terraform plan -var-file'
alias tfdv='terraform destroy -var-file'
alias tfi='terraform import'
alias tfiv='terraform import -var-file'
alias tfcv='terraform console -var-file'
alias tftaint='terraform taint'
alias tfuntaint='terraform untaint'
alias tffmt='terraform fmt -recursive -diff'
alias tfstate='terraform state'
alias tfs='terraform state'
alias tft='terraform test'
alias tfsh='terraform show'
alias rmtf='rm -rf .terraform/'
alias tfw='terraform workspace'
alias tfws='terraform workspace select'
alias tfwl='terraform workspace list'
alias tfwn='terraform workspace new'
alias tfwd='terraform workspace delete'

if (( $+commands[terraform] )); then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform
fi
