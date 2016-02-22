express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'

app = express()
app.set 'view engine', 'jade'
app.use express.static 'static'
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use cookieParser()

app.use require './controllers'

app.listen 4444
