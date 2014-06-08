FROM crosbymichael/dockerui

MANTAINER Alexander Erm 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y nginx supervisor

ADD .authbasic /app/.authbasic
ADD nginx_default.conf /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf


RUN mkdir -p /etc/nginx/ssl
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Unknown/L=Unknown/O=Dis/CN=localhost" -keyout /etc/nginx/ssl/server.key  -out /etc/nginx/ssl/server.crt

# RUN openssl genrsa -des3 -out /etc/nginx/ssl/server.key 2048
# RUN openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr
# RUN openssl x509 -req -days 365 -in /etc/nginx/ssl/server.csr -signkey /etc/nginx/ssl/server.key -out /etc/nginx/server.crt


ADD supervisor.conf /etc/supervisor/conf.d/dockerui.conf

EXPOSE 80

# CMD -c "/usr/bin/supervisord -n
#ENTRYPOINT ["/bin/bash", "-c"]

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/conf.d/dockerui.conf"]