#!/bin/bash
#
# chkconfig: 35 90 12
# description: Tensorboard server
#

# Get function from functions library
#. /etc/init.d/functions

# Start the service tensorboard
start() {
        logdir=../runs
        initlog -c "echo -n Starting Tensorboard server: "
        /home/paepcke/anaconda3/envs/tensorboard_server/bin/tensorboard --logdir $logdir&
        ### Create the lock file ###
        touch /var/lock/subsys/tensorboard
        #success $"Tensorboard server startup"
        echo $"Tensorboard server startup"
        echo
}

# Restart the service Tensorboard
stop() {
        initlog -c "echo -n Stopping Tensorboard server: "
        killproc tensorboard
        ### Now, delete the lock file ###
        rm -f /var/lock/subsys/tensorboard
        echo
}

### main logic ###
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status tensorboard
        ;;
  restart|reload|condrestart)
        stop
        start
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|status}"
        exit 1
esac

exit 0
