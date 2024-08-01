FROM nginx:latest

RUN rm -f /etc/nginx/conf.d/default.conf /usr/share/nginx/html/index.html

ADD nginx/conf.d/default.conf /etc/nginx/conf.d

ADD htdocs/resume /usr/share/nginx/html/resume
