import { Container, CssBaseline, ThemeProvider } from '@mui/material'
import { theme } from './theme'
import Header from './components/header'
import { Camera } from './components/cameraView'

function App() {

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Header />
      <Container maxWidth='md'>
        <Camera />
      </Container>
    </ThemeProvider>
  )
}

export default App
