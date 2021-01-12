if git ls-remote --exit-code --heads origin $BRANCH; then
  echo "Branch found"
else
  echo "Branch not found"
  git checkout -B $BRANCH
  git push -u origin $BRANCH
fi