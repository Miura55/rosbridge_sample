# ROS Bridge Sampele(for Devcontainer)

## How to Launch Devcontainer
1. Launch VS Code and open this repository
2. Press `Ctrl + Shift + P` and exec command `Dev Cotainers: Rebuild Without Cache and Reopen in Container`

## How to Run ROS node
1. Run `docker exec -it rosbridge_server bash` to execution ros environ
2. Run `rosrun dummy_sensor publish_sonar.py` to pubslish sensor topic
