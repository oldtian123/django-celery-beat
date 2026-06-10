FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        binutils \
        gcc \
        git \
        patch \
        procps \
        sed \
    && rm -rf /var/lib/apt/lists/*

# Copy application code from repo directory
COPY . .

# Install Python dependencies and application
RUN python -m pip install --upgrade pip setuptools wheel \
    && python -m pip install -r requirements/default.txt \
    && python -m pip install -r requirements/runtime.txt \
    && python -m pip install -r requirements/test.txt \
    && python -m pip install -r requirements/test-ci.txt \
    && python -m pip install -r requirements/pkgutils.txt \
    && python -m pip install -r requirements/docs.txt \
    && python -m pip install -e . \
    && mkdir -p /app/result

EXPOSE 8000