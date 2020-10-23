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
alias tfv='terraform validate'
alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfd='terraform destroy'
alias tfi='terraform import'
alias tfc='terraform console'
alias tftaint='terraform taint'
alias tfuntaint='terraform untaint'
alias tffmt='terraform fmt -recursive -diff'
alias tfo='terraform output'
alias tfstate='terraform state'
alias rmtf='rm -rf .terraform/ || rm -rf *state*'