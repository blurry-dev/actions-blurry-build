# Setup Blurry Docker action

This action builds your [Blurry](https://github.com/blurry-dev/blurry) static site.

## Inputs

None yet

## Outputs

Your built site

## Example usage

Add this as a step to your build & deploy job in GitHub:

```yaml
- name: Blur site 🌫️
  uses: blurry-dev/setup-blurry@v0.3
  with:
    context: .
    cache-from: type=gha
    cache-to: type=gha,mode=max
```

The example includes using the experimental [GitHub Actions cache for Docker](https://docs.docker.com/build/ci/github-actions/cache/#github-cache)