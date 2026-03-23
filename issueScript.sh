#!/bin/bash

REPOS=(
  # Here goes the repos that you want to create the issues in
  # Have to be written in the format
  # Owner/reponame
)

ISSUES=(
  # Here goes the list of all the issues that will be create
  # Have to be written in the format
  # Title of the issue/markdown.mb
)

echo "Staring issues creation"

for REPO in "${REPOS[@]}"; do
  echo "--------------------------------------------"
  echo "working on $REPO"

  #Clone the if the repo could not be found on the computer.
  if [ ! -d "${REPO##*/}" ]; then
    gh repo clone "$REPO"
  else
    echo "Repo already cloned. No need to clone."
  fi

  #Goes into the Repos dirctory
  cd "${REPO##*/}" || {
    echo "Error: could not enter $REPO"
    continue
  }

  #takes the string with the title and filenamn of the body and splits it into two strings
  #The body is in a its on folder to have it saved in markdown
  for ITEM in "${ISSUES[@]}"; do
    TITLE="${ITEM%%|*}"
    FILENAME="${ITEM##*|}"

    FILEPATH="../issues/$FILENAME"

    #Checks the so that the markdown file does exist and if so create the an issue with the
    # Github CLI.
    if [ -f "$FILEPATH" ]; then
      gh issue create --title "$TITLE" --body-file "$FILEPATH"
      echo "created issue '$TITLE' with $FILEPATH"
    else
      echo "ERROR: could not find $FILEPATH"
    fi
    sleep 1
  done

  cd ..

done
