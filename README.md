# Validate WordPress Site Version

[![GitHub License](https://img.shields.io/github/license/jazzsequence/action-validate-plugin-version)](https://github.com/jazzsequence/action-validate-wp-site-version/blob/main/LICENSE)
[![Validate WP Site Version Test](https://github.com/jazzsequence/action-validate-wp-site-version/actions/workflows/test.yml/badge.svg)](https://github.com/jazzsequence/action-validate-wp-site-version/actions/workflows/test.yml)


Checks the installed WordPress version on a Pantheon site and optionally updates it to the latest if it's out-of-date.

## Usage

```yaml
name: Validate WordPress Site Version
on:
  schedule:
    - cron: '0 0 * * 0'
jobs:
  validate-wp:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v6
      with:
        fetch-depth: 0
    - name: Validate WP site version
      uses: jazzsequence/action-validate-wp-site-version@v1
      with:
        machine-token: ${{ secrets.TERMINUS_TOKEN }}
        pantheon-site: my-pantheon-site
        apply-upstream-updates: true
```

## Configuration

### Inputs

#### `machine-token`
**Required**

A Pantheon machine token with access to make changes to the site being tested.

#### `pantheon-site`
**Required**

The Pantheon site slug (e.g. `my-pantheon-site`) or UUID to pass to Terminus to access the site.

#### `ssh-key`
**Required**

A SSH key for a user with access to the site. Required for WP-CLI commands via Terminus.

#### `environment`
_Optional_

The site environment to test. Defaults to `dev`.

#### `apply-upstream-updates`
_Optional_

Whether to apply upstream updates if WordPress is out of date. Defaults to `false`.
