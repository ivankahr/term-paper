exec = require './helpers/exec_sql'
db = require './helpers/db'
path = require 'path'

exec path.join(__dirname, './sql/remove.sql'), (res) ->
    if not res? then console.log 'CREATE ERROR!'
    else console.log 'DELETED OK!'

    exec path.join(__dirname, './sql/create.sql'), (res) ->
        if not res? then console.log 'CREATE ERROR!'
        else console.log 'CREATED OK!'
        db.end()
