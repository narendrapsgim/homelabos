#!/usr/bin/env bash

# Contains HLOS specific tasks related to on-this-host tasks.

# Prints the Logo
Task::logo() {
    : @desc "Prints the Logo"

  Task::sudo_check

  if [[ -v "already_ran[${FUNCNAME[0]}]" ]] ;  then exit 0; fi
  already_ran[${FUNCNAME[0]}]=1
  cat homelaboslogo.txt
  Task::check_version
  printf "MOTD:\n\n" && curl -m 2 https://gitlab.com/NickBusey/HomelabOS/raw/master/MOTD || printf "Could not get MOTD"
  printf "\n\n"

  Task::sanity_check
  Task::v7migrations
}

Task::generate_ansible_pass(){
  if [[ "$OSTYPE" == "darwin"* ]]; then
    function sha256sum() { shasum -a 256 "$@" ; } && export -f sha256sum
  fi
  date +%s | sha256sum | base64 | head -c 32  > ~/.homelabos_vault_pass
}

# Builds the docker image used for HomelabOS Deployments
Task::build() {
    : @desc "Builds the Docker Image used to deploy"
    : @param force "Forces a rebuild of the docker image"

  if ! [[ -z $_force ]] ; then
    docker images -a | grep "homelabos" | awk '{print $3}' | xargs docker rmi --force
  fi

  if [[ -v "already_ran[${FUNCNAME[0]}]" ]] ;  then exit 0; fi
  already_ran[${FUNCNAME[0]}]=1
  highlight "Preparing HomelabOS Docker Image"
  sudo docker inspect --type=image homelabos:$VERSION > /dev/null && highlight " Docker Image Already Built" || sudo docker build . -t homelabos:$VERSION
}

# Manually forces a settings Sync via Git
Task::git_sync() {
  : @desc "Manually forces a settings sync via git"

  if [[ -v "already_ran[${FUNCNAME[0]}]" ]] ;  then exit 0; fi
  already_ran[${FUNCNAME[0]}]=1
  mkdir -p settings > /dev/null 2>&1
  # If there is a git repo, then attempt to update
  if [ -d settings/.git/ ]; then
    mkdir -p settings/.git/hooks/ > /dev/null 2>&1
    cp git_sync_pre_commit settings/.git/hooks/pre-commit
    chmod +x settings/.git/hooks/pre-commit
    cd settings
    colorize orange "Syncing settings via Git"
    git pull
    git add * > /dev/null
    git commit -a -m "Settings update" || true
    git push > /dev/null
  else
    colorize orange "Warning! You do not have a git repo set up for your settings. Make sure to back them up using some other method. https://homelabos.com/docs/setup/installation/#syncing-settings-via-git "
  fi
  cd ..

}

# Encrypt the vault
Task::encrypt(){
  : @desc "Encrypts the vault"
  Task::run_docker ansible-vault encrypt settings/vault.yml
}

# Decrypts the vault
Task::decrypt(){
  : @desc "Decrypts the vault"

  highlight "Decrypting Vault"
  Task::run_docker ansible-vault decrypt settings/vault.yml || true
  highlight "Vault decrypted!"
}

# Uninstalls HomelabOS
Task::uninstall(){
  : @desc "Uninstalls HomelabOS"

  Task::logo
  Task::build

  highlight "Uninstall HomelabOS Completely"
  Task::run_docker ansible-playbook --extra-vars="@settings/config.yml" --extra-vars="@settings/vault.yml" -i inventory -t deploy playbook.remove.yml
  highlight "Uninstall Complete"
}

# Restores a server from Backups. Assuming Backups were running
Task::restore() {
  : @desc "Restore a server from backups. Assuming backups were running"
  Task::run_docker ansible-playbook --extra-vars="@settings/config.yml" --extra-vars="@settings/vault.yml" -i inventory restore.yml
}

# Opens a shell in the HomelabOS deploy container
Task::shell() {
  : @desc "Opens a shell in the HomelabOS deploy container"

  Task::run_docker /bin/bash
}

# Allows you to switch between various branches and tags of HLOS
Task::track(){
  : @desc "Switches you to the specified branch or tag. use branch=<branchname>"
  : @param branch! "Required! Branch or tag name to track"

  git checkout $_branch
}

Task::run_docker() {
  echo "command: $@"
  docker run --rm -it \
  -v $HOME/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v $HOME/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/data \
  -v $HOME/.homelabos_vault_pass:/ansible_vault_pass \
  homelabos:${VERSION} "$@"
}

# Checks the current version
Task::check_version() {
  : @desc "Checks the current version"

  VERSION_CURRENT=$(cat VERSION)
  VERSION_LATEST=$(curl -s -m 2 https://gitlab.com/NickBusey/HomelabOS/raw/master/VERSION)

  function version_gt() { test "$(echo "$@" | tr " " "\n" | sort | head -n 1)" != "$1"; }

  colorize orange "You currently have version: $VERSION_CURRENT"
  colorize green "The newest Version available is: $VERSION_LATEST"

  if version_gt $VERSION_LATEST $VERSION_CURRENT; then
    colorize red "* You should update to version $VERSION_LATEST! *"
    colorize red " * Update at https://gitlab.com/NickBusey/HomelabOS/-/releases *"
  else
    colorize green "You are up to date!"
  fi
}
