# Setup Blurry Docker action

This action builds your [Blurry](https://github.com/blurry-dev/blurry) static site.

## Inputs

### `site-root`

**Required** The root of your static site, i.e. the directory with your `blurry.toml`.
Default `"./"`.

## Outputs

Your build directory located in `${{ github.workspace }}`, e.g., `${{ github.workspace }}/dist`

## Example usage

See below for an example of how to build a Blurry site and deploy it to Netlify whenever your GitHub repo's `main` branch is updated:

```yaml
# .github/workflows/deploy.yml
name: Build and Deploy
on:
  push:
    branches:
      - main
permissions:
  contents: read
jobs:
  build-and-deploy:
    concurrency: ci-${{ github.ref }} # Recommended if you intend to make multiple deployments in quick succession.
    runs-on: ubuntu-latest
    steps:
      - name: Checkout 🛎️
        uses: actions/checkout@v4

      - name: Blur site 🌫️
        uses: blurry-dev/actions-blurry-build@main

      - name: Deploy to Netlify 🚀
        uses: nwtgck/actions-netlify@v2.0
        with:
          publish-dir: ${{ github.workspace }}/dist
          production-branch: main
          deploy-message: "Deploy from GitHub Actions"
          enable-pull-request-comment: false
          enable-commit-comment: true
          overwrites-pull-request-comment: true
        env:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
        timeout-minutes: 1
```
