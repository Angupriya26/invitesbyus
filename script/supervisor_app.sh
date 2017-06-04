#!/bin/bash
cat <<- EOF > /etc/supervisor/conf.d/supervisord.conf
[supervisord]
nodaemon=true

[program:pt_app]
stopasgroup=true
command=/bin/bash -c "/usr/src/app/script/start_app.sh"
EOF

/usr/bin/supervisord
