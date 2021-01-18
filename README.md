# Theme Kit Download Action

A GitHub action that pulls changes from Shopify Theme Kit themes.

* Creates a configured branch if it doesn't exist.
* Downloads the theme files from the configured theme.
* Commits any new changes.
* Can be configured to exclude files and directories.
* Creates a pull request for the changes.

## Usage

The action requires the following environment variables to run.

* `BRANCH` - The branch name for the changes to be committed to.
* `SHOPIFY_APP_API_PASSWORD` - API password for your Shopify app.
* `SHOPIFY_STORE_URL` - The store URL in format `my-store.myshopify.com` of your store.
* `SHOPIFY_THEME_ID` - The ID of the theme to deploy to.
* `THEME_PATH` - The path of your theme in your repository. If root use `./`.
* `THEMEKIT_FLAGS` (optional) - [Shopify Theme Kit configuration flags](https://shopify.github.io/themekit/configuration/#flags).

It is recommended that you use [encrypted secrets](https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository) for your environment details.

They can easily be used in your workflow configuration like so:

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