# Contributing Guidelines

The project accepts contributions via GitHub pull requests. This document outlines the process to help get your contribution accepted.

### Reporting a Bug

This repository is used by developers for maintaining project. If your issue is in another tool, please use the issue tracker that repository.

Please use the Issues feature of this repo to report issues.

### How to Contribute

1. Fork this repository, develop and test your change.
1. Submit a pull request w/o compiling an bin/*.exe.  This will be compiled on merge

***NOTE***: In order to make testing and merging of PRs easier, please submit changes to in separate PRs.

#### Technical requirements

* Must for written for Windows 2012 or higher
* Updates to the README.md `Thanks` section if you are reusing code
* Images should not have any major security vulnerabilities
* Must be up-to-date with the latest stable `kubectl` features/client version
* Only leverage `kubectl` stable version

#### Documentation requirements

* Must include an in-depth `README.md`, including:
    * Usage examples for new features

#### Merge approval and release process

A maintainer reviews the submission, and start a validation job in the CI to verify the technical requirements. A maintainer may add "LGTM" (Looks Good To Me) or an equivalent comment to indicate that a PR is acceptable. Any change requires at least one LGTM. No pull requests can be merged until at least one maintainer signs off with an LGTM.

Once the PR has been merged, the release job will automatically run in the CI to package and release `bin/kubectxwin.exe`

### Support Channels

The best I have right now are issues with labels.  More to come