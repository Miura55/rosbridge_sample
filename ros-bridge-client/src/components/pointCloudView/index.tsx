import { useEffect } from "react";
import { Card, CardHeader } from "@mui/material";
import * as ROS3D from 'ros3d';
import { ros, tfClient } from "../../services/subscriber";

export const PointCloudView = () => {
  useEffect(() => {
    const viewer = new ROS3D.Viewer({
      divID: 'pointcloud-viewer',
      width: window.innerWidth,
      height: window.innerHeight,
      antialias: true,
      cameraPose: {
        x: 0,
        y: 0,
        z: 10
      }
    });
    const pointCloud = new ROS3D.PointCloud2({
      ros: ros,
      tfClient: tfClient,
      rootObject: viewer.scene,
      topic: '/velodyne_points',
      material: { size: 0.05, color: 0xff00ff }
    });
  }, []);


  return (
    <Card sx={{ minWidth: 345 }}>
      <CardHeader
        title="PointCloud"
        subheader="/velodyne_points"
      />
      <div id='pointcloud-viewer' />
    </Card>
  );
};
