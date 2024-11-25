'use strict'

// Yes, the db is currently a json file...
var readFile = require('fs-readfile-promise')
var data = readFile('back/models/db.json', 'utf8')

var onRejected = function (err) {
  console.log(err)
}

var parsedData = data.then(function (data) {
  return JSON.parse(data)
}, onRejected)

module.exports = (function () {
  var projects = {
    all: function () {
      return parsedData.then(function (data) {
        return data.projects
      })
    }
  }

  return { projects }
})()
