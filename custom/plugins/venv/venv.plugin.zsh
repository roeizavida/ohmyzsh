# Auto activate and deactivate Python venv.
# Only works for venv dirs with the name ".venv" in the working directory.

function chpwd() {
  # Check if ".venv" dir exists in the working directory
  if [[ -d ".venv" ]]
  then
    # Activate venv
    source ./.venv/bin/activate
  # If ".venv" dir does not exists
  else
    # Check if venv is activated (".venv" in Python path)
    if [[ $(which python3) == *"/.venv/bin/python" ]]
    then
      # Deactivate venv
      deactivate
    fi
  fi
}