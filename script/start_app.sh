#!/bin/sh
cron start;
# cp /usr/src/app/script/logrotate_app /etc/logrotate.d/
run_nginx(){
  eval "sed -i '/rails_env/c\rails_env   '"$RAILS_ENV"';' /opt/nginx/conf/nginx.conf"
  /opt/nginx/sbin/nginx
  echo "inside supervison"
}

main(){
  cd /usr/src/app/
  run_nginx
}

main
