# -----
FROM python:3.9.18-slim-bullseye AS builder

ENV \
    # python:
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    # pip:
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # poetry:
    POETRY_VERSION=1.3.1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    PATH="$PATH:/root/.local/bin"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
    build-essential=12.9 \
    curl=7.74.0-1.3+deb11u11 \
  && curl -sSL https://install.python-poetry.org | python3 \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get clean -y  \
  && rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/root/.local/bin"

WORKDIR /build

COPY poetry.lock pyproject.toml ./
RUN  poetry config virtualenvs.create false \
  && poetry install --no-root --no-dev

COPY src src

RUN poetry build

# -----
FROM python:3.9.18-slim-bullseye

LABEL org.opencontainers.image.source=https://github.com/okp4/template-python

COPY --from=builder /build/dist/*.whl /tmp/whl/

RUN  python3 -m pip install --no-cache-dir /tmp/whl/*.whl \
  && rm -rf /tmp/whl

ENTRYPOINT ["my-app"]
