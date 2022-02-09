FROM nginx:1.21.6-alpine
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/* ;\
    echo "sed -i 's/XXX/'\$port'/g' /etc/nginx/nginx.conf" >> /run.sh ;\
    echo "if [ -z \$port ]; then echo [error] You did not specify the port for listen; exit 1; fi" >> /run.sh ;\
    echo "if [ -z \$server1 ] && [ -z \$server2 ] && [ -z \$server3 ] && [ -z \$server4 ] && [ -z \$server5 ]; then echo [error] You need to specify at least 1 server for load balancing; exit 2; fi" >> /run.sh ;\
    echo "if [ ! -z \$server1 ]; then sed -i 's/AAA/'\$server1'/g' /etc/nginx/nginx.conf; echo connected backend - \$server1; fi" >> /run.sh ;\
    echo "if [ ! -z \$server2 ]; then sed -i 's/BBB/'\$server2'/g' /etc/nginx/nginx.conf; echo connected backend - \$server2; fi" >> /run.sh ;\
    echo "if [ ! -z \$server3 ]; then sed -i 's/CCC/'\$server3'/g' /etc/nginx/nginx.conf; echo connected backend - \$server3; fi" >> /run.sh ;\
    echo "if [ ! -z \$server4 ]; then sed -i 's/DDD/'\$server4'/g' /etc/nginx/nginx.conf; echo connected backend - \$server4; fi" >> /run.sh ;\
    echo "if [ ! -z \$server5 ]; then sed -i 's/EEE/'\$server5'/g' /etc/nginx/nginx.conf; echo connected backend - \$server5; fi" >> /run.sh ;\
    echo "sed -i '/AAA\|BBB\|CCC\|DDD\|EEE/d' /etc/nginx/nginx.conf" >> /run.sh ;\
    echo "nginx -g 'daemon off;'" >> /run.sh ;\
    chmod +x /run.sh
ENTRYPOINT /run.sh
