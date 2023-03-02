import { Card, CardHeader, CardMedia } from '@mui/material';
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
    <Card sx={{minWidth: 345}}>
      <CardHeader
        title="Camera"
        subheader="camera/compressed"
      />
      <CardMedia
        component="img"
        width={60}
        image={imageData}
        alt="Camera"
      />
    </Card>
  );
};
