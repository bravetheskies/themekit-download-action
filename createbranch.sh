if git ls-remote --exit-code --heads origin ${{ env.branch }}; then
  echo "Branch found"
else
  echo "Branch not found"
  git checkout -B ${{ env.branch }}
  git push -u origin ${{ env.branch }}
fi