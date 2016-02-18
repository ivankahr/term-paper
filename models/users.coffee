db = require '../helpers/db'

exports.new = (name, cb) ->
    db.query '''
    INSERT INTO users (name) VALUES (?)
    ''', [name], (err, res) ->
        return cb? null if err?
        cb? res

exports.get = (cb) ->
    db.query '''
    SELECT * FROM users ORDER BY id
    ''', (err, res) ->
        return cb? null if err?
        cb? res
