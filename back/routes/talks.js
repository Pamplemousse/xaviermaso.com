'use strict'

const express = require('express')
const router = express.Router()

const talks = require('../models/data.js').talks

/* GET talks page. */
router.get('/', function (req, res) {
  talks.all().then(function (data) {
    res.send(data)
  })
})

module.exports = router
