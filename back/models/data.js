'use strict'

// Yes, the db is currently a json file...
const readFile = require('fs-readfile-promise')
const data = readFile('back/models/db.json', 'utf8')

const onRejected = function (err) {
  console.log(err)
}

const parsedData = data.then(function (data) {
  return JSON.parse(data)
}, onRejected)

module.exports = (function () {
  const projects = {
    all: function () {
      return parsedData.then(function (data) {
        return data.projects
      })
    }
  }

  const talks = {
    all: function () {
      return parsedData.then(function (data) {
        return data.talks
      })
    }
  }

  return { projects, talks }
})()
