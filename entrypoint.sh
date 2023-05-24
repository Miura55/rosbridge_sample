#!/bin/bash
set -e

source /opt/ros/noetic/setup.bash
roslaunch rosbridge_server rosbridge_websocket.launch

exec "$@"
