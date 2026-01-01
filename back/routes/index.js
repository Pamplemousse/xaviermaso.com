'use strict'

const express = require('express')
const path = require('path')
const router = express.Router()

/* GET single page application */
router.get('/', function (req, res) {
  if (process.env.NODE_ENV === 'production') {
    res.sendFile('index.html', { root: path.join(__dirname, '../../dist/') })
  } else {
    // redirect to webpack-dev-server
    res.redirect('http://localhost:8080/')
  }
})

module.exports = router
