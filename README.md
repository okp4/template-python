# Python Project Template

> Template for Python Projects [@okp4](okp4.com).

[![conventional commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

## Purpose & Philosophy

This repository holds the template for building python projects with a consistent set of standards accross all okp4 python projects. We are convinced that the quality of the code depends on clear and consistent coding conventions, with an automated enforcement (CI).

This way, the template promotes:

- the use of [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/), [semantic versionning](https://semver.org/) and [semantic releasing](https://github.com/cycjimmy/semantic-release-action) which automates the whole package release workflow including: determining the next version number, generating the release notes, and publishing the artifacts (project tarball, docker images, etc.)
- a uniform way for managing the project lifecycle (depencencies management, building, testing)
- KISS principles: simple for developers
- a consistent coding style

## How to use

> 🚨 do not fork this repository as it is a [template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)

1. Click on [Use this template](https://github.com/rochacbruno/python-project-template/generate)
2. Give a name to your project
3. Wait until the first run of CI finishes
4. Clone your new project and happy coding!

## System requirements

### Python

The repository targets python `3.9` and higher.

### Poetry

The repository uses [Poetry](https://python-poetry.org) as python packaging and dependency management. Be sure to have it properly installed before.

```sh
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
```

## What's included

This template provides the following:

- [poetry](https://python-poetry.org) for dependency management.
- [flake8](https://flake8.pycqa.org) for linting.
- [unittest](https://docs.python.org) for unit testing.

The project is also configured to enforce code quality by declaring some CI workflows:

- conventional commits
- lint
- unit test
- semantic release

## Everyday activity

### Build

Project is built by [poetry](https://python-poetry.org).

```sh
poetry install
```

### Lint

Code linting is performed by [flake8](https://flake8.pycqa.org).

> ⚠️ Be sure to write code compliant with `flake8` rules or else you'll be rejected by the CI.

```sh
poetry run flake8 --count --show-source --statistics
```

### Unit Test

Unit tests are performed by the [unittest](https://docs.python.org) testing framework.

> ⚠️ Be sure to write tests that succeed or else you'll be rejected by the CI.

```sh
poetry run python -m unittest discover
```

## Contributing

So you want to contribute? Great. We appreciate any help you're willing to give. Don't hesitate to open issues and/or submit pull requests.

Remember that this is the template we use at [OKP4](okp4.com/), and that we apply everywhere in our private and public Python projects. This is why we may have to refuse change requests simply because they do not comply with our internal requirements, and not because they are not relevant.
