'use strict'

require('./styles/main.scss')

var devAPI = 'http://localhost:8000/api'
var prodAPI = 'https://www.xaviermaso.com/api'
var API = (process.env.NODE_ENV === 'production') ? prodAPI : devAPI

var catGifsUrl = 'https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat'
var projectsUrl = API + '/projects'

var Elm = require('../elm/Main').Elm

Elm.Main.init({
  flags: {
    projectsUrl: projectsUrl,
    catGifsUrl: catGifsUrl
  }
})
