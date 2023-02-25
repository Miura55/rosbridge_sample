import { AppBar, Toolbar, Typography } from "@mui/material";

export default function Header() {
  return (
    <AppBar color="primary" position="static">
      <Toolbar>
        <Typography>ROS Bridge Sample</Typography>
      </Toolbar>
    </AppBar>
  );
}
