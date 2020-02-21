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

RUN curl -sS https://getcomposer.org/installer | php -- \
--install-dir=/usr/bin --filename=composer && chmod +x /usr/bin/composer 

RUN mkdir /phplint && cd /phplint && composer require overtrue/phplint && ln -s /phplint/vendor/bin/phplint /usr/local/bin/phplint

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
