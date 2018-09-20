FROM benhutchins/taiga
MAINTAINER Benjamin Hutchins <ben@hutchins.co>

## Install Slack extension
RUN LC_ALL=C pip install --no-cache-dir taiga-contrib-slack && \
    mkdir -p /usr/src/taiga-front-dist/dist/plugins/slack/ && \
    SLACK_VERSION=$(pip freeze|grep taiga-contrib-slack|sed -e 's/.*==//') && \
    echo "taiga-contrib-slack version: $SLACK_VERSION" && \
    curl https://raw.githubusercontent.com/taigaio/taiga-contrib-slack/$SLACK_VERSION/front/dist/slack.js -o /usr/src/taiga-front-dist/dist/plugins/slack/slack.js && \
    curl https://raw.githubusercontent.com/taigaio/taiga-contrib-slack/$SLACK_VERSION/front/dist/slack.json -o /usr/src/taiga-front-dist/dist/plugins/slack/slack.json

## Install LDAP extensions
# RUN pip install --no-cache-dir taiga-contrib-ldap-auth

COPY taiga-conf/local.py /taiga/local.py
COPY taiga-conf/conf.json /taiga/conf.json
