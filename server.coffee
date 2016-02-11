express = require 'express'
db = require './helpers/db'

app = express()

app.get '/', (req, res) ->
    res.send ivanka: 42

app.listen 8080
