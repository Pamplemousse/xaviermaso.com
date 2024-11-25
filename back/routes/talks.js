'use strict'

var express = require('express')
var router = express.Router()

var talks = require('../models/data.js').talks

/* GET talks page. */
router.get('/', function (req, res) {
  talks.all().then(function (data) {
    res.send(data)
  })
})

module.exports = router
