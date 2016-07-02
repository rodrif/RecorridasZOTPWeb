#!/bin/bash
/bin/bash -l -c 'cd $OPENSHIFT_REPO_DIR && bundle exec bin/rails runner -e production "NotificacionDataAccess.enviarNotificaciones"'
