'use strict'

const axios = require('axios')
const path = require('path')
const slowDown = require('express-slow-down')

var express = require('express')
var router = express.Router()

const speedLimiter = slowDown({
  windowMs: 15 * 60 * 1000, // keep the record of requests for 15 minutes
  delayAfter: 5, // allow 5 requests to go at full-speed, then...
  delayMs: 500 // 6th request has a 500ms delay, 7th has a 1000ms delay, 8th gets 1500ms, etc.
})

router.get('/', speedLimiter, function (req, res) {
  if (process.env.NODE_ENV !== 'production') {
    // Expose a stubbed giphy's API response in non production mode.
    res.sendFile(path.join(__dirname, '../stubs/meow.json'))
  }

  // "Proxy" to the Giphy API to get a random cat GIF.
  const catGifUrl = `https://api.giphy.com/v1/gifs/random?api_key=${process.env.GIPHY_API_KEY}&tag=cat`

  axios.get(catGifUrl)
    .then(function (r) {
      res
        .status(r.status)
        .set('Content-Type', r.headers['content-type'])
        .send(r.data)
    })
    .catch(function (error) {
      const r = error.response
      res
        .status(r.status)
        .set('Content-Type', r.headers['content-type'])
        .send(r.data)
    })
})

module.exports = router
