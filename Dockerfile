FROM --platform=linux/amd64 docker.io/library/debian:trixie

COPY --from=docker.io/library/composer:latest /usr/bin/composer /usr/bin/composer

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install --yes git libzip-dev unzip nodejs npm php8.4-cli php8.4-intl php8.4-zip php8.4-mysql php8.4-xml php8.4-mbstring && \
    rm -rf /var/lib/apt/lists/*

RUN echo "alias ls='ls --color -A'" >> /root/.bashrc

CMD [ "/usr/bin/env","bash" ]