query = require '../helpers/query'
db = require '../helpers/db'
async = require 'async'

exports.saveAll = (arr, cb) ->
    EmptyMess = message: 'Empty array of answers!'
    return cb EmptyMess if arr.length < 1

    questionsIds = {}
    savedIds = []
    withIds = []
    withoutIds = []
    for obj in arr
        questionsIds[obj.question_id] = yes
        if obj.id?
            savedIds.push obj.id
            withIds.push obj
        else withoutIds.push obj
    questionsIds = Object.keys questionsIds

    tasks =
        updated: (cb) ->
            return cb null, EmptyMess if withIds.length < 1

            updateLines = (for obj in withIds
                formated = [obj.content, obj.correct, obj.id]
                db.format 'UPDATE answers SET content=?, correct=? WHERE id=?', formated
            ).join ';\n'

            query updateLines, (res) -> cb null, res

        inserted: (cb) ->
            return cb null, EmptyMess if withoutIds.length < 1

            formated = for obj in withoutIds then [obj.content, obj.correct, obj.question_id]
            query '''
                INSERT INTO answers (content, correct, question_id) VALUES ?
                ''', [formated], (res) -> cb null, res

    exports.clearAnswers questionsIds, savedIds, (removed) ->
        async.parallel tasks, (err, answersRes) ->
            answersRes.removed = removed
            cb answersRes

exports.get = (id, cb) ->
    query '''
        SELECT * FROM answers WHERE id = ?
        ''', [id], (tests) -> cb tests[0]

exports.getByIds = (ids, cb) ->
    query """
        SELECT * FROM answers WHERE id IN (#{ids.join(',')})
        """, cb

exports.getAnotherAnswers = (answersIds, cb) ->
    exports.getByIds answersIds, (_answers) ->
        questionsIds = for item in _answers then item.question_id
        query """
            SELECT * FROM answers WHERE question_id IN (#{questionsIds.join(',')})
            """, cb

exports.getByQuestions = (ids, cb) ->
    return cb [] if not ids? or ids.length < 1
    query """
        SELECT * FROM answers WHERE question_id IN (#{ids.join(',')}) ORDER BY id
        """, cb

exports.clearAnswers = (questionsIds, except, cb) ->
    exceptSegment = if except.length > 0 then "AND id NOT IN (#{except.join(',')})" else ''
    query """
        DELETE FROM answers WHERE question_id IN (#{questionsIds.join(',')}) #{exceptSegment}
        """, cb
