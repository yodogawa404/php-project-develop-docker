FROM --platform=linux/amd64 docker.io/library/debian:trixie

COPY --from=docker.io/library/composer:latest /usr/bin/composer /usr/bin/composer

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install --yes git libzip-dev unzip nodejs npm \
    php8.4-bcmath php8.4-cli php8.4-common php8.4-curl php8.4-fpm php8.4-gd php8.4-intl php8.4-mbstring php8.4-mysql php8.4-sqlite3 php8.4-xml php8.4-zip && \
    rm -rf /var/lib/apt/lists/*

RUN echo "alias ls='ls --color -A'" >> /root/.bashrc

CMD [ "/usr/bin/env","bash" ]