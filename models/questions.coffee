query = require '../helpers/query'
db = require '../helpers/db'
answers = require './answers'
async = require 'async'

exports.saveAll = (arr, cb) ->
    EmptyMess = message: 'Empty array of questions!'
    return cb EmptyMess if arr.length < 1

    testId = arr[0].test_id
    savedIds = []
    withIds = []
    withoutIds = []
    for obj in arr
        if obj.id?
            savedIds.push obj.id
            withIds.push obj
        else withoutIds.push obj

    answersList = []
    tasks =
        updated: (cb) ->
            return cb null, EmptyMess if withIds.length < 1

            updateLines = (for obj in withIds
                db.format 'UPDATE questions SET content=? WHERE id=?', [obj.content, obj.id]
            ).join ';\n'

            query updateLines, (res) ->
                for question in withIds
                    for answer in question.answers
                        answer.question_id = question.id
                        answersList.push answer
                cb null, res

        inserted: (cb) ->
            return cb null, EmptyMess if withoutIds.length < 1

            formated = for obj in withoutIds then [obj.content, obj.test_id]
            query '''
                INSERT INTO questions (content, test_id) VALUES ?
                ''', [formated], (res) ->
                firstId = res.insertId

                for question, i in withoutIds
                    for answer in question.answers
                        answer.question_id = firstId + i
                        answersList.push answer
                cb null, res

    exports.clearQuestions testId, savedIds, (questionsRemovedRes) ->
        async.parallel tasks, (err, questionsRes) ->
            answers.saveAll answersList, (answersRes) ->
                questionsRes.removed = questionsRemovedRes
                cb questions: questionsRes, answers: answersRes

exports.getByTest = (testId, cb) ->
    query '''
        SELECT * FROM questions WHERE test_id = ? ORDER BY id
        ''', [testId], (questions) ->
            ids = []
            byIds = {}

            for question in questions
                question.answers = []
                byIds[question.id] = question
                ids.push question.id

            answers.getByQuestions ids, (answers) ->
                byIds[answer.question_id].answers.push answer for answer in answers
                cb (question for id, question of byIds)

exports.get = (id, cb) ->
    query '''
        SELECT * FROM questions WHERE id = ? ORDER BY id
        ''', [id], (questions) -> cb questions[0]

exports.clearQuestions = (testId, except, cb) ->
    exceptSegment = if except.length > 0 then "AND id NOT IN (#{except.join(',')})" else ''
    query """
        DELETE FROM questions WHERE test_id = ? #{exceptSegment}
        """, [testId], cb
