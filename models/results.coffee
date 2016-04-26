query = require '../helpers/query'
answers = require './answers'
questions = require './questions'
tests = require './tests'

format = (answers, questions, tests) ->
    testsByIds = {}
    questionsByIds = {}
    answersByIds = {}

    for test in tests
        test.questions = {}
        testsByIds[test.id] = test

    for question in questions
        question.answers = {}
        questionsByIds[question.id] = question
        testsByIds[question.test_id].questions[question.id] = question

    for answer in answers
        answer.selected = no
        answersByIds[answer.id] = answer
        questionsByIds[answer.question_id].answers[answer.id] = answer

    for tid, test of testsByIds
        test.questions = for qid, question of test.questions
            for aid, answer of question.answers
                question.answer = answer
                break
            question
        test


exports.save = (arr, cb) ->
    formated = []
    answersIds = []
    for item in arr
        formated.push [item.user_id, item.answer_id]
        answersIds.push item.answer_id

    answers.getAnotherAnswers answersIds, (_answers) ->
        ids = for item in _answers then item.id

        exports.deleteByAnswers ids, ->
            query """
                INSERT INTO results (user_id, answer_id) VALUES ?
                """, [formated], cb

exports.deleteByAnswers = (ids, cb) ->
    query """
        DELETE FROM results WHERE answer_id IN (#{ids.join(',')})
        """, cb

exports.getByUser = (userId, cb) ->
    query '''
        SELECT * FROM results WHERE user_id = ? ORDER BY id
        ''', [userId], (_results) ->
        return cb [] if _results.length < 1

        answersIds = for item in _results then item.answer_id
        answers.getByIds answersIds, (_answers) ->

            questionsIds = for item in _answers then item.question_id
            questions.getByIds questionsIds, (_questions) ->

                testsIds = for item in _questions then item.test_id
                tests.getByIds testsIds, (_tests) ->

                    cb format _answers, _questions, _tests
