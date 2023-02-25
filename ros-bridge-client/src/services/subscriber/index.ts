import ROSLIB from "roslib";

const ros = new ROSLIB.Ros({
  url: 'ws://localhost:9090'
});

ros.on('connection', () => {
  console.log('connected');  
});

ros.on('error', (error: any) => {
  console.log(error);
});

ros.on('close', () => {
  console.log('closed');
});

export const imageTopic = new ROSLIB.Topic({
  ros: ros,
  name: '/head_camera/image_raw/compressed',
  messageType: 'sensor_msg/CompressedImage'
});
