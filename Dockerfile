FROM fluent/fluentd:latest-onbuild
MAINTAINER mofo@mofo.com

ENV WORKDIR /fluentd
WORKDIR $WORKDIR

USER root
RUN chown -R root:root $WORKDIR \
    && rm -rf /home/fluent \
    && gem install \
        fluent-plugin-elasticsearch \
    && gem sources -c

EXPOSE 24224

VOLUME [$WORKDIR/buffer, $WORKDIR/log]

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
