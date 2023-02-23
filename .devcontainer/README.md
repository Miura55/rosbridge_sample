# ROS Bridge Sampele(for Devcontainer)

## How to Launch Devcontainer
1. Launch VS Code and open this repository
2. Press `Ctrl + Shift + P` and exec command `Dev Cotainers: Rebuild Without Cache and Reopen in Container`

## How to Run ROS node
1. Run `docker exec -it rosbridge_server bash` to execution ros environ
2. Run `rosrun dummy_sensor publish_sonar.py` to pubslish sensor topic
3. Run `roslaunch dummy_sensor webcam.launch` to publish webcam topic

### How to display webcam view
1. Run `xhost local:` at you host os.
2. Launch Devcontainer and `docker exec -it rosbridge_server bash`
3. Run `roslaunch dummy_sensor webcam.launch view:=true`, then you can display webcam view
