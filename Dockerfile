FROM infibeam/ruby1.9.3:14.04
MAINTAINER Angupriya angupriya26@gmail.com

RUN apt-get update
RUN apt-get install -y supervisor memcached cron openssh-server openssh-client zip libmysqlclient-dev mysql-client-5.5 && mkdir -p /var/log/supervisor

#install passenger
ENV PASSENGER_VERSION 4.0.37
RUN /bin/bash -l -c 'gem install rack --version 1.4.7 && gem install passenger --version $PASSENGER_VERSION'
RUN /bin/bash -l -c 'passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx'
RUN mkdir -p /opt/nginx/logs
RUN touch /opt/nginx/logs/access.log
RUN touch /opt/nginx/logs/error.log
RUN ln -sf /dev/stdout /opt/nginx/logs/access.log
RUN ln -sf /dev/stderr /opt/nginx/logs/error.log

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD nginx.conf /opt/nginx/conf/nginx.conf
RUN echo "daemon off;" >> /opt/nginx/conf/nginx.conf
Add Gemfile  /usr/src/app/Gemfile
Add Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install --system
ADD . /usr/src/app
RUN chown -R infibeam:infibeam /usr/src/app

EXPOSE 80
RUN chmod u+x /usr/src/app/script/supervisor_app.sh
RUN chmod u+x /usr/src/app/script/start_app.sh
