FROM nginx:alpine
RUN apk update; apk add jq curl git; cd /tmp; \
    git clone https://github.com/medov-alexey/curl.git; \
    cd curl/elasticsearch; apk del git; mv ./gcmr_for_docker.sh /; \
    rm -rf /tmp/curl; rm -rf /var/cache/apk/*; \
    mkdir -p /var/spool/cron/crontabs; mkdir -p /etc/periodic; \
    echo "echo \"\$CRON\" sh /gcmr_for_docker.sh > /var/spool/cron/crontabs/root" >> /start.sh; \
    echo "nginx -g 'daemon on;'" >> /start.sh; \
    echo "busybox crond -f" >> /start.sh; \
    echo el_count_message 0 > /usr/share/nginx/html/metrics; \
    chmod +x /start.sh
CMD /start.sh
