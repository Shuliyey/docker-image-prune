#!/bin/bash -x
#
# A helper script for ENTRYPOINT.

set -e

syslogger_tag=""

if [ -n "${SYSLOGGER_TAG}" ]; then
  syslogger_tag=" -t "${SYSLOGGER_TAG}
fi

syslogger_command=""

if [ -n "${SYSLOGGER}" ]; then
  syslogger_command="logger "${syslogger_tag}
fi

function output()
{
  if [ -n "${SYSLOGGER}" ]; then
    logger ${syslogger_tag} "$@"
  fi
  echo "$@"
}

# Logrotate status file handling
croninterval="0 0 0 * * *"

if [ -n "${CRONSCHEDULE}" ]; then
  croninterval=${CRONSCHEDULE}
fi

# ----- Cron Start ------

if [ "$1" = 'cron' ]; then
  /usr/bin/go-cron "${croninterval}" /bin/bash -c "/root/docker-image-prune.sh"
fi

#-----------------------

exec "$@"
