express = require 'express'
stylus = require 'stylus'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'

app = express()
app.set 'view engine', 'jade'
app.use require './controllers'
app.use express.static 'static'
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use cookieParser()
app.use stylus.middleware
  src: 'stylus'
  dest: 'static/css'
  debug: true
  force: true

app.listen 4444
