# ROS Bridge Sampele(for Devcontainer)

## How to Launch Devcontainer
1. Launch VS Code and open this repository
2. Press `Ctrl + Shift + P` and exec command `Dev Cotainers: Rebuild Without Cache and Reopen in Container`

## How to Run ROS Node
1. Download sample rosbag data
```bash
cd dummy_sensor/data
wget https://storage.googleapis.com/cruise-webviz-public/demo.bag
```
2. Run node
```bash
 docker exec -it rosbridge_server bash -c "source /catkin_ws/devel/setup.bash && roslaunch dummy_sensor play_demo.launch"
```
