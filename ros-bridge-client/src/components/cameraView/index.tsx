import { useState, useEffect } from 'react';
import ROSLIB from 'roslib';

export const Camera = () => {
  const [imageData, setImageData] = useState('');

  useEffect(() => {
    const ros = new ROSLIB.Ros({
      url: 'ws://localhost:9090',
    });

    const imageTopic = new ROSLIB.Topic({
      ros: ros,
      name: '/head_camera/image_raw/compressed',
      messageType: 'sensor_msgs/CompressedImage',
    });

    imageTopic.subscribe((message: any) => {
      setImageData(`data:image/png;base64,${message.data}`);
    });

    return () => {
      imageTopic.unsubscribe();
      ros.close();
    };
  }, []);

  return (
    <div>
      {imageData && <img src={imageData} alt="camera" />}
    </div>
  );
};
