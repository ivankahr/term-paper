db = require './helpers/db'
fs = require 'fs'

module.exports = (file, cb) ->
    sql = fs.readFileSync(file, 'utf-8')
    db.query sql, (err, res) ->
        return cb? null if err?
        cb? res
