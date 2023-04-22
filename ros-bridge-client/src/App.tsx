import { CssBaseline, Grid, ThemeProvider } from '@mui/material'
import { theme } from './theme'
import Header from './components/header'
import { Camera } from './components/cameraView'
import { PointCloudView } from './components/pointCloudView'

function App() {

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Header />
      <Grid container alignItems='center' justifyContent='center'>
        <Grid item xs={8}>
          <Camera />
          <PointCloudView />
        </Grid>
      </Grid>
    </ThemeProvider>
  )
}

export default App
