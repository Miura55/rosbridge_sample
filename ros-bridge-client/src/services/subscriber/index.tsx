import ROSLIB from "roslib";

export const ros = new ROSLIB.Ros({
  url: 'ws://localhost:9090',
});

export const imageTopic = new ROSLIB.Topic({
  ros: ros,
  name: 'camera/compressed',
  messageType: 'sensor_msgs/CompressedImage',
});

export const pointCloudTopic = new ROSLIB.Topic({
  ros: ros,
  name: '/velodyne_points',
  messageType: 'sensor_msgs/PointCloud2'
});

export const tfClient = new ROSLIB.TFClient({
  ros : ros,
  angularThres : 0.01,
  transThres : 0.01,
  rate : 10.0,
  fixedFrame: 'velodyne'
});
