[![Test](https://github.com/radxa-docs/pre-commit-hooks/actions/workflows/test.yaml/badge.svg)](https://github.com/radxa-docs/pre-commit-hooks/actions/workflows/test.yaml)

# pre-commit-hooks

Radxa-specific hooks to enforce our documentation policies

## Hooks available

### `use-webp-image`

Prevent non-webp image from being commited. svg is allowed.

Currently does not automatically convert the image.

### `fix-en-dash-list`

Detect and fix potential misuse of en dash in Markdown list.

## Development against `radxa-doc/documentation`

First, run `pre-commit install` to ensure this repo is also shell checked.

Please refer to `pre-commit` documentation about [developing hooks interactively](https://pre-commit.com/#developing-hooks-interactively).

In short, run the following command in `radxa-doc/documentation` project folder:

```bash
pre-commit try-repo ../pre-commit-hooks --verbose --all-files
```
