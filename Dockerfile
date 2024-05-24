# Python 3.9イメージをベースに使用
FROM python:3.9
WORKDIR /app

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN git config --global --add safe.directory /app

RUN pip install poetry \
    && poetry config virtualenvs.create false

# pyproject.tomlとpoetry.lockをコピーして依存関係をインストール
# COPY ./pyproject.toml ./poetry.lock* ./
# RUN poetry install --no-root

# requirements.txtをコピーし、依存関係をインストール
COPY ./requirements.txt* ./
RUN poetry init --no-interaction && poetry add $(cat requirements.txt)