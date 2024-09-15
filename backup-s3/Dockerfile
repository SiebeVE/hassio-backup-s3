ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install python + pip
RUN \
  apk add --no-cache \
    python3 py3-pip py3-yaml jq

# Prepare venv
RUN python3 -m venv venv

# add aws-cli and deps
RUN source ./venv/bin/activate && pip install awscli

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
