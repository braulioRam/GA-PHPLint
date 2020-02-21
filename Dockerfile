FROM php:7.2-cli

LABEL "com.github.actions.name"="GA-PHPLint"
LABEL "com.github.actions.description"="Run PHP linter on PR"
LABEL "com.github.actions.icon"="aperture"
LABEL "com.github.actions.color"="blue"

LABEL version="0.0.1"
LABEL repository="http://github.com/braulioRam/GA-PHPLint"
LABEL homepage="http://github.com/braulioRam/GA-PHPLint"
LABEL maintainer="Braulio Ramirez <braulio.ramirez@justia.com>"

RUN apt-get update && apt-get -y install zip unzip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/local/bin/composer

RUN mkdir /phplint && cd /phplint && composer require overtrue/phplint && ln -s /phplint/vendor/bin/phplint /usr/local/bin/phplint

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
