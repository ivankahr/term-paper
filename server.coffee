express = require 'express'
users = require './models/users'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
session = require 'express-session'
MySQLStore = require('express-mysql-session')(session)
config = require './config.json'

app = express()
app.set 'view engine', 'jade'
app.use express.static 'static'
app.use express.static 'bower_components'
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use cookieParser()
app.use session
    name: "term-paper.#{config.port}.sid"
    secret: '42 is my best number'
    unset: 'destroy'
    resave: no
    saveUninitialized: no
    store: new MySQLStore config.db

app.use '/api', require './controllers'

app.get '*', (req, res) ->
    if req.session.uid?
        users.get req.session.uid, (user) ->
            if user? then res.render 'index', user: user
            else
                delete req.session.uid
                res.render 'login'
    else res.render 'login'

app.listen config.port, -> console.log 'Started on localhost:4444'
