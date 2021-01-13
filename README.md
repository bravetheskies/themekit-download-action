# Theme Kit Download Action

A GitHub action that pulls changes from Shopify Theme Kit themes.

* Creates a configured branch if it doesn't exist.
* Downloads the theme files from the configured theme.
* Commits any new changes.
* Can be configured to exclude files and directories.
* Creates a pull request for the changes.

## Usage

```yml
- uses: bravetheskies/themekit-download-action@latest
  env:
    BRANCH: branch-name
    SHOPIFY_APP_API_PASSWORD: ${{ secrets.SHOPIFY_APP_API_PASSWORD }}
    SHOPIFY_STORE_URL: ${{ secrets.SHOPIFY_STORE_URL }}
    SHOPIFY_THEME_ID: ${{ secrets.SHOPIFY_THEME_ID }}
    THEME_PATH: ${{ secrets.SHOPIFY_THEME_PATH }}
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```