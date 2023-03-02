import ROSLIB from "roslib";

const ros = new ROSLIB.Ros({
  url: 'ws://localhost:9090',
});

export const imageTopic = new ROSLIB.Topic({
  ros: ros,
  name: 'camera/compressed',
  messageType: 'sensor_msgs/CompressedImage',
});
