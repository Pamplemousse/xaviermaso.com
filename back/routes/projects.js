'use strict'

var express = require('express')
var router = express.Router()

var projects = require('../models/data.js').projects

/* GET projects page. */
router.get('/', function (req, res) {
  projects.all().then(function (data) {
    res.send(data)
  })
})

module.exports = router
