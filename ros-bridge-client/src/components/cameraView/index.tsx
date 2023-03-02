import { Box } from '@mui/material';
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
    <Box sx={{minWidth: 100}}>
      <img src={imageData} alt="camera" />
    </Box>
  );
};
