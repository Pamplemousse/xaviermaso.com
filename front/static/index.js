'use strict'

require('./styles/main.scss')

const devAPI = 'http://localhost:8000/api'
const prodAPI = 'https://www.xaviermaso.com/api'
const API = (process.env.NODE_ENV === 'production') ? prodAPI : devAPI

const catGifsUrl = API + '/meow'
const projectsUrl = API + '/projects'
const talksUrl = API + '/talks'

const Elm = require('../elm/Main').Elm

Elm.Main.init({
  flags: {
    projectsUrl,
    talksUrl,
    catGifsUrl
  }
})
