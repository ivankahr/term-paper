db = require './db'
fs = require 'fs'

module.exports = (file, cb) ->
    sql = fs.readFileSync(file, 'utf-8')
    db.query sql, (err, res) ->
        if err?
            console.log err
            cb? null
        else cb? res
