express = require 'express'
users = require './models/users'

app = express()
app.set 'view engine', 'jade'

app.get '/', (req, res) ->
    users.get (users) ->
        if not users? then res.render 'error'
        else res.render 'index', users: users

app.listen 4444
