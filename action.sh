#!/bin/bash
set -e

main_branch=$(git symbolic-ref --short HEAD)

if git ls-remote --exit-code --heads origin $BRANCH; then
  echo "Branch $BRANCH found"
  git fetch
  git checkout $BRANCH
else
  echo "Branch $BRANCH not found, creating branch"
  git checkout -B $BRANCH
  git push -u origin $BRANCH
fi

echo "Current branch: $(git branch --show-current)"

echo "Installing Theme Kit"
curl -s https://raw.githubusercontent.com/Shopify/themekit/master/scripts/install.py | sudo python

echo "Configuring Theme Kit"
theme configure --password=$SHOPIFY_APP_API_PASSWORD --store=$SHOPIFY_STORE_URL --themeid=$SHOPIFY_THEME_ID --dir=$THEME_PATH

echo "Downloading theme files"
theme download

git add .

if ! git diff-index --quiet HEAD --; then
  echo "Changes found, commiting and pushing"
  git commit -m "$GITHUB_WORKFLOW #$GITHUB_RUN_NUMBER"
  git push
  if hub pr list -h $BRANCH | grep "#"; then
    echo "Pull request already exists"
  else
    echo "Pull request doesn't exist"
    hub pull-request --no-edit --base=$main_branch
  fi
else
  echo "No changes found"
fi