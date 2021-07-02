FROM fluent/fluentd:v1.12-debian-1

# Use root account to use apt
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN buildDeps="sudo make gcc g++ libc-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && apt-get install -y curl logrotate unzip \
 && sudo gem install fluent-plugin-newrelic \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip \
 && ./aws/install && rm -rf /etc/logrotate.d/* \
 && useradd -d /home/awsuser awsuser
 
COPY aws /home/awsuser/.aws
COPY conf/aws_rotation.conf /etc/logrotate.d/
COPY conf/fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

USER fluent

