FROM php:8.1-cli
ENV PATH="/var/jenkins_home/.composer/vendor/bin:${PATH}"
ENV COMPOSER_HOME="/var/jenkins_home/.composer"
ENV NPM_CONFIG_CACHE="/var/jenkins_home/.npm/cache"

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir /usr/local/bin --filename composer \
    && rm composer-setup.php

RUN apt-get update \
    && apt-get install -y unzip libzip-dev libpng-dev git gnupg2 awscli \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs build-essential \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn \
    && apt-get clean \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd

RUN yarn global add node-sass@^4.9 gulp


RUN git config --global user.email "developers@publica.co.nz" \
    && git config --global user.name "Jenkins build bot" \
    && mkdir ~/.ssh \
    && echo "bitbucket.org,104.192.143.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==" > ~/.ssh/known_hosts

ENTRYPOINT []
