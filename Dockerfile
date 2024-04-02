# Container image that runs your code
FROM python:3.12-bullseye

# RUN echo "### Install dependencies" >> $GITHUB_STEP_SUMMARY

RUN apt remove "*imagemagick*" --purge -y && apt autoremove --purge -y

RUN apt-get -qq update && apt-get -qq install -y ffmpeg build-essential

# RUN echo "### Build & install ImageMacick 7" >> $GITHUB_STEP_SUMMARY

RUN git clone https://github.com/SoftCreatR/imei && \
cd imei && \
chmod +x imei.sh && \
./imei.sh


ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY pyproject.toml /pyproject.toml
COPY poetry.lock /poetry.lock

WORKDIR /

# RUN echo "### Install Poetry and Python dependencies" >> $GITHUB_STEP_SUMMARY

RUN pip install poetry
RUN poetry install --no-root

# RUN echo "### Blurring site" >> $GITHUB_STEP_SUMMARY

WORKDIR /github/workspace

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
