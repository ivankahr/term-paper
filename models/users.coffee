query = require '../helpers/query'

exports.save = (obj, cb) ->
    if obj.id
        method = 'UPDATE'
        where = "WHERE id = #{obj.id}"
    else
        method = 'INSERT INTO'
        where = ''

    obj.admin ?= no
    query """
        #{method} users SET name = ?, admin = ? #{where}
        """, [obj.name, obj.admin], cb

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
