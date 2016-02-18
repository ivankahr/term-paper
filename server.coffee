express = require 'express'
users = require './models/users'

app = express()
app.set 'view engine', 'jade'

app.get '/', (req, res) ->
    users.getAll (users) ->
        if not users? then res.render 'error'
        else res.render 'index', users: users

app.get '/user/:id/', (req, res) ->
    users.get req.params.id, (user) ->
        if not user? then res.render 'error'
        else res.render 'user', user: user

app.listen 4444
