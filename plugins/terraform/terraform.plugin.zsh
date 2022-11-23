###############################################
# Functions
###############################################
function tf_prompt_info() {
  # dont show 'default' workspace in home dir
  [[ "$PWD" != ~ ]] || return
  # check if in terraform dir and file exists
  [[ -d .terraform && -r .terraform/environment ]] || return

  local workspace="$(< .terraform/environment)"
  echo "${ZSH_THEME_TF_PROMPT_PREFIX-[}${workspace:gs/%/%%}${ZSH_THEME_TF_PROMPT_SUFFIX-]}"
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
alias tfp='terraform plan'
alias tfpv='terraform plan -var-file'
alias tfd='terraform destroy'
alias tfdv='terraform destroy -var-file'
alias tfi='terraform import'
alias tfiv='terraform import -var-file'
alias tfc='terraform console'
alias tfcv='terraform console -var-file'
alias tftaint='terraform taint'
alias tfuntaint='terraform untaint'
alias tffmt='terraform fmt -recursive -diff'
alias tfo='terraform output'
alias tfstate='terraform state'
alias rmtf='rm -rf .terraform/'

if (( $+commands[terraform] )); then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform
fi
