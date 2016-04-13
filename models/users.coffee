query = require '../helpers/query'

exports.new = (name, cb) ->
    query '''
        INSERT INTO users (name) VALUES (?)
        ''', [name], cb

exports.getAll = (cb) ->
    query '''
        SELECT * FROM users ORDER BY id
        ''', cb

exports.get = (id, cb) ->
    query '''
        SELECT * FROM users WHERE id = ? ORDER BY id
        ''', [id], (users) -> cb users[0]

exports.delete = (id, cb) ->
    query '''
        DELETE FROM users WHERE id = ?
        ''', [id], cb
