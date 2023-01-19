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
