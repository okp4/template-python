# -----
FROM python:3.9.7-slim-buster AS builder

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
    POETRY_VERSION=1.1.7 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    PATH="$PATH:/root/.poetry/bin"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN  apt-get update \
  && apt-get install --no-install-recommends -y \
    build-essential=12.6 \
    curl=7.64.0-4+deb10u2 \
  && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get clean -y  \
  && rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/root/.poetry/bin"

WORKDIR /build

COPY poetry.lock pyproject.toml ./
RUN  poetry config virtualenvs.create false \
  && poetry install --no-root --no-dev

COPY src src

RUN poetry build

# -----
FROM python:3.9.7-slim-buster

LABEL org.opencontainers.image.source=https://github.com/okp4/template-python-project

COPY --from=builder /build/dist/*.whl /tmp/whl/

RUN  python3 -m pip install --no-cache-dir /tmp/whl/*.whl \
  && rm -rf /tmp/whl

ENTRYPOINT ["my-app"]
