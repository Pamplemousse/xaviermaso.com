'use strict'

var express = require('express')
var path = require('path')
var logger = require('morgan')
var cors = require('cors')

var app = express()

var server = app.listen(8000, function () {
  console.log('Listening on port %d', server.address().port)
})

app.use(logger('dev'))
app.use(express.static(path.join(__dirname, '../dist')))

if (process.env.NODE_ENV !== 'production') {
  // allow access control from different origin in non production mode
  app.use(cors())

  // expose a stubbed giphy's API response in non production mode
  app.use('/api/meow', function (req, res) {
    res.header('Content-Type', 'application/json')
    res.sendFile(path.join(__dirname, 'stubs/meow.json'))
  })
}

app.use('/api/projects', require('./routes/projects'))
app.use('*', require('./routes/index'))

// catch 404 and forwarding to error handler
app.use(function (req, res, next) {
  var err = new Error('Not Found')
  err.status = 404
  next(err)
})

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function (err, req, res, next) {
    res.status(500)
      .send({
        message: err.message,
        error: err
      })
  })
}

// production error handler
// no stacktraces leaked to user
app.use(function (err, req, res, next) {
  res.status(500)
    .send({ message: err.message })
})

module.exports = app
