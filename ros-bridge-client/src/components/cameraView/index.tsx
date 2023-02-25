import { useState, useEffect } from 'react';
import { imageTopic } from '../../services/subscriber';

export const Camera = () => {
  const [imageData, setImageData] = useState('');

  useEffect(() => {
    imageTopic.subscribe((message: any) => {
      setImageData(`data:image/png;base64,${message.data}`);
    });
  }, []);

  return (
    <>
      {imageData && <img src={imageData} alt="camera" />}
    </>
  );
};
