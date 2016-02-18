express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
users = require './models/users'

app = express()
app.set 'view engine', 'jade'
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use cookieParser()
app.use express.static 'static'

app.get '/', (req, res) ->
    users.getAll (users) ->
        if not users? then res.render 'error'
        else res.render 'index', users: users

app.get '/user/new/', (req, res) ->
    res.render 'user_new'

app.post '/user/new/', (req, res) ->
    users.new req.body.name, (saved) ->
        if not saved? then res.render 'error',
            msg: 'Помилка створення користувача!'
            link:
                title: 'Повторити введення'
                href: '/user/new/'
        else res.redirect "/user/#{saved.insertId}"

app.get '/user/:id/', (req, res) ->
    users.get req.params.id, (user) ->
        if not user? then res.render 'error'
        else res.render 'user', user: user

app.listen 4444
