function tf_prompt_info() {
    # dont show 'default' workspace in home dir
    [[ "$PWD" == ~ ]] && return
    # check if in terraform dir
    if [ -d .terraform ]; then
      workspace=$(terraform workspace show 2> /dev/null) || return
      echo "[${workspace}]"
    fi
}

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