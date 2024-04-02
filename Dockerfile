# Container image that runs your code
FROM python:3.12-bullseye

# Installs ImageMagick with AVIF support
RUN apt remove "*imagemagick*" --purge -y && apt autoremove --purge -y

RUN apt-get -qq update && apt-get -qq install -y ffmpeg build-essential

RUN git clone https://github.com/SoftCreatR/imei && \
cd imei && \
chmod +x imei.sh && \
./imei.sh

# Installs Poetry
ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN pip install poetry

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Installs Python dependencies
WORKDIR /github/workspace

RUN poetry install --no-root

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
