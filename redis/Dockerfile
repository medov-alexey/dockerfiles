FROM redis:6-alpine
COPY redis.conf /etc/redis/redis.conf
RUN echo "sysctl vm.overcommit_memory=1 > /dev/null 2>&1" >> /run.sh ;\
    echo "sed -i 's/XXX/'\$password'/g' /etc/redis/redis.conf" >> /run.sh ;\
    echo "sed -i 's/YYY/'\$memory_size'/g' /etc/redis/redis.conf" >> /run.sh ;\
    echo "redis-server /etc/redis/redis.conf" >> /run.sh ;\
    chmod +x /run.sh
ENTRYPOINT /run.sh
