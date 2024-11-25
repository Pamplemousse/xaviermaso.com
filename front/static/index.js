'use strict'

require('./styles/main.scss')

var devAPI = 'http://localhost:8000/api'
var prodAPI = 'https://www.xaviermaso.com/api'
var API = (process.env.NODE_ENV === 'production') ? prodAPI : devAPI

var catGifsUrl = API + '/meow'
var projectsUrl = API + '/projects'
var talksUrl = API + '/talks'

var Elm = require('../elm/Main').Elm

Elm.Main.init({
  flags: {
    projectsUrl: projectsUrl,
    talksUrl: talksUrl,
    catGifsUrl: catGifsUrl
  }
})
