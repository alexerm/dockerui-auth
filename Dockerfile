FROM crosbymichael/dockerui

MANTAINER Alexander Erm <alexerm@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y nginx supervisor

ADD .htpasswd /app/.htpasswd
ADD nginx_default.conf /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf


RUN mkdir -p /etc/nginx/ssl
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Unknown/L=Unknown/O=Dis/CN=localhost" -keyout /etc/nginx/ssl/server.key  -out /etc/nginx/ssl/server.crt


ADD supervisor.conf /etc/supervisor/conf.d/dockerui.conf

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/conf.d/dockerui.conf"]