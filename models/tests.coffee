query = require '../helpers/query'
questions = require './questions'

exports.save = (obj, cb) ->
    if obj.id
        method = 'UPDATE'
        where = "WHERE id = #{obj.id}"
    else
        method = 'INSERT INTO'
        where = ''

    query """
        #{method} tests SET name = ? #{where}
        """, [obj.name], (res) ->
        testId = obj.id or res.insertId
        question.test_id = testId for question in obj.questions

        questions.saveAll obj.questions, cb

exports.get = (id, cb) ->
    query '''
        SELECT * FROM tests WHERE id = ? ORDER BY id
        ''', [id], (tests) -> cb tests[0]

exports.getAll = (cb) ->
    query '''
        SELECT * FROM tests ORDER BY id
        ''', cb

exports.delete = (id, cb) ->
    query '''
        DELETE FROM tests WHERE id = ?
        ''', [id], cb
