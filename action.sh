#!/bin/bash

if git ls-remote --exit-code --heads origin $BRANCH; then
  echo "Branch $BRANCH found"
  git fetch
  git checkout $BRANCH
else
  echo "Branch $BRANCH not found, creating branch"
  git checkout -B $BRANCH
  git push -u origin $BRANCH
fi

echo "Current branch:"
git branch --show-current

echo "Installing Theme Kit"
curl -s https://shopify.github.io/themekit/scripts/install.py | sudo python

echo "Configuring Theme Kit"
theme configure --password=$SHOPIFY_APP_API_PASSWORD --store=$SHOPIFY_STORE_URL --themeid=$SHOPIFY_THEME_ID --dir=$THEME_PATH --ignored-file=config/settings_data.json --ignored-file=locales/*

echo "Downloading theme files"
theme download

git add .

if ! git diff-index --quiet HEAD --; then
  echo "Changes found, commiting and pushing"
  git commit -m "Changes from live on CI run $GITHUB_RUN_NUMBER"
  git push
  hub pull-request --no-edit
else
  echo "No changes found"
fi