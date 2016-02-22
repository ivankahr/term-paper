query = require '../helpers/query'

exports.new = (name, cb) ->
    query '''
    INSERT INTO tests (name) VALUES (?)
    ''', [name], cb

exports.getAll = (cb) ->
    query '''
    SELECT * FROM tests ORDER BY id
    ''', cb

exports.get = (id, cb) ->
    query '''
    SELECT * FROM tests WHERE id = ? ORDER BY id
    ''', [id], (tests) -> cb tests[0]
