FROM alpine:latest
RUN apk update; apk add bash jq curl git; cd /tmp; \
    git clone https://github.com/medov-alexey/curl.git; \
    cd curl/rancher/1.6.30; apk del git; mv ./restart_service.sh /; \
    rm -rf /tmp/curl; rm -rf /var/cache/apk/*; \
    mkdir -p /var/spool/cron/crontabs; mkdir -p /etc/periodic; \
    echo "echo \"\$CRON\" bash /restart_service.sh > /var/spool/cron/crontabs/root" >> /start.sh; \
    echo "busybox crond -f" >> /start.sh; \
    chmod +x /start.sh
CMD /start.sh
