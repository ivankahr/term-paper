query = require '../helpers/query'
db = require '../helpers/db'
async = require 'async'

exports.saveAll = (arr, cb) ->
    EmptyMess = message: 'Empty array of answers!'
    return cb EmptyMess if arr.length < 1

    withIds = []
    withoutIds = []
    for obj in arr
        if obj.id? then withIds.push obj
        else withoutIds.push obj

    tasks =
        updated: (cb) ->
            return cb null, EmptyMess if withIds.length < 1

            updateLines = (
                for obj in withIds
                    db.format "UPDATE answers SET content=?, correct=? WHERE id=?", [obj.content, obj.correct, obj.id]
                ).join ';\n'

            query updateLines, (res) -> cb null, res

        inserted: (cb) ->
            return cb null, EmptyMess if withoutIds.length < 1

            formated = for obj in withoutIds then [obj.content, obj.correct, obj.question_id]
            query '''
            INSERT INTO answers (content, correct, question_id) VALUES ?
            ''', [formated], (res) -> cb null, res

    async.parallel tasks, (err, answersRes) ->
        cb answersRes

exports.get = (id, cb) ->
    query '''
    SELECT * FROM answers WHERE id = ?
    ''', [id], (tests) -> cb tests[0]

exports.getAll = (cb) ->
    query '''
    SELECT * FROM answers ORDER BY id
    ''', cb
