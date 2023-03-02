# ROS Bridge Sampele
This is a sample ROS package for ROS Bridge.

## How to use
1. Build Docker container
```bash
$ docker compose build
```

2. Run Docker container
```bash
$ docker compose run --rm ros
```

3. Run ROS Bridge
```bash
$ docker compose up -d
```

4. Run ROS Node
```bash
$ docker compose exec -it ros bash
$ rosrun dummy_sensor publish_sonar.py
```

5. Connect `http://localhost:9090` with your websocket client, and send message like below.
```json
{
  "op": "subscribe",
  "topic": "/sonar",
  "type": "sensor_msgs/Range"
}
```

## How to Use WebCam node 
1. Run `docker exec -it rosbridge_server bash` to execution ros environ
2. Run `rosrun dummy_sensor publish_sonar.py` to pubslish sensor topic
3. Run `roslaunch dummy_sensor webcam.launch` to publish webcam topic

### How to display webcam view
1. Run `xhost local:` at you host os.
2. Launch Devcontainer and `docker exec -it rosbridge_server bash`
3. Run `roslaunch dummy_sensor webcam.launch view:=true`, then you can display webcam view
