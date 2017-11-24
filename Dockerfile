FROM centos/php-70-centos7:latest

USER root
ENV VERSION="4.7.5" \
    APP_PATH="/opt/app-root/src"
LABEL version=${VERSION}

RUN cd ${APP_PATH} && \
    wget -q https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.zip && \
    unzip phpMyAdmin-${VERSION}-all-languages.zip && \
    rm -f phpMyAdmin-${VERSION}-all-languages.zip && \
    mv phpMyAdmin-${VERSION}-all-languages/* ./  && \
    rm -rf phpMyAdmin-${VERSION}-all-languages && \
    rm -f config.sample.inc.php && \
    chown -R 1001:0 ${APP_PATH} && \
    chmod -R ug+rwx ${APP_PATH}

COPY config.inc.php ${APP_PATH}/config.inc.php

USER 1001
EXPOSE 8080
CMD ${STI_SCRIPTS_PATH}/run
