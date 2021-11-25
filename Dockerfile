FROM alpine:3.15

EXPOSE 80

RUN echo "Installing base packages" \
	&& apk add --update --no-cache \
	bash \
	dumb-init \
	socat \
	supervisor \
	python3 \
	busybox \
	busybox-extras \
	&& echo "Removing apk cache" \
	&& rm -rf /var/cache/apk/

RUN mkdir -p /var/log/supervisor
COPY supervisor/*.sh /usr/sbin
RUN chmod +x /usr/sbin/*.sh

RUN mkdir -p /etc/supervisor.d
COPY supervisor/*.ini /etc/supervisor.d/

RUN chmod +x /usr/bin/dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/bin/sh", "-c", "/usr/sbin/create_conf.sh && exec /usr/bin/supervisord -c /etc/supervisord.conf -n"]