FROM debian:buster-slim

RUN	apt update -y && apt upgrade -y \
    && apt-get install -y ca-certificates lsb-release apt-transport-https iproute2 tzdata curl \
    && adduser --disabled-password --home /home/container container \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update && apt -y install php7.4

RUN apt-get install -y php7.4-xml

USER container
ENV  USER=container HOME=/home/container
WORKDIR	/home/container
COPY ./entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]