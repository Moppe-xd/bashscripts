#!/bin/bash

REPOS=(
  # Here goes the repos that you want to edit the issue in.
  # Have to be written in the format
  # Owner/reponame
)

ISSUES=(
  # Here goes the issues you want to change
  # Have to be written in the format
  # issue number/newissue
)

echo "Starting updating issues"

for REPO in "${REPOS[@]}"; do
  echo "--------------------------------------------"
  echo "working on $REPO"

  #Clone the repo if the repo could not be found on the computer
  if [ ! -d "${REPOS##*/}" ]; then
    gh repo clone "$REPO"
  else
    echo "REPO already cloned. No need to clone."
  fi

  cd "${REPO##*/}" || {
    echo "Error: could not enter $REPO"
    continue
  }

  for ITEM in "${ISSUES[@]}"; do
    NUMBER="${ITEM%%|*}"
    FILE="${ITEM##*|}"

    FILEPATH="../issues/$FILE"

    if [ -f "$FILEPATH" ]; then
      gh issue edit "$NUMBER" --body-file "$FILEPATH"
      echo "Updated issue $NUMBER with $FILEPATH"
    else
      echo "Error: could not find $FILEPATH"
    fi
    sleep 1
  done

  #Goes back to the root dirctory and removes the git repo
  cd ..
  rm -rf "${REPO##*/}"
done
