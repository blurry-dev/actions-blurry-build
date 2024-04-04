# Container image that runs your code
FROM johnfraney/docker-python-imagemagick7

ENV PATH="/root/.local/bin:${PATH}"

RUN pipx ensurepath

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
