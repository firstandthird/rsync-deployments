#!/bin/bash

echo "Start ---"

VALID=true

if [[ -z "$INPUT_DEPLOY_HOST" ]]; then
  echo "You Must pass in the deployment host"
  VALID=false
fi

if [[ -z "$INPUT_DEPLOY_PATH" ]]; then
  echo "You Must pass in the deployment path"
  VALID=false
fi

if [[ -z "$INPUT_DEPLOY_USER" ]]; then
  echo "You Must pass in the deployment user"
  VALID=false
fi

if [[ -z "$INPUT_DEPLOY_HOST" ]]; then
  echo "You Must pass in the deployment host"
  VALID=false
fi

if [[ -z "$INPUT_REPO_PATH" ]]; then
  echo "You Must pass in the path in the repository"
  VALID=false
fi

if [ "$VALID"=false ]; then
  echo " --- FAIL: Invalid parameters"
  exit 1
fi

FULL_PATH="$GITHUB_WORKSPACE/$INPUT_REPO_PATH"

if [[ "$DEPLOY_PASS" ]]; then
  echo "Deploy via password";
  rsync -ratv --rsh="sshpass -p $DEPLOY_PASS ssh -o StrictHostKeyChecking=no -l $INPUT_DEPLOY_USER" $FULL_PATH $INPUT_DEPLOY_HOST:$INPUT_DEPLOY_PATH
fi

if [[ "$DEPLOY_KEY" ]]; then
  echo "Deploy ssh key";
  SSH_PATH="$HOME/.ssh"
  mkdir "$SSH_PATH"
  echo "$DEPLOY_KEY" > "$SSH_PATH/deploy_key"
  chmod 600 "$SSH_PATH/deploy_key"

  rsync -ratv -rsh='ssh -i $SSH_PATH/deploy_key -o StrictHostKeyChecking=no' $FULL_PATH $INPUT_DEPLOY_USER@$INPUT_DEPLOY_HOST:$INPUT_DEPLOY_PATH
fi