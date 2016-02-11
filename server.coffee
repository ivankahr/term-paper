express = require 'express'

app = express()

app.get '/', (req, res) ->
    res.send ivanka: 42

app.listen 8080
