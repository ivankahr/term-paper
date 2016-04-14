express = require 'express'
router = express.Router()
tests = require '../models/tests'

router.get '/get/', (req, res) ->
    tests.getAll (tests) ->
        if not tests? then res.send error: 'Помилка вибірки тестів!'
        else res.send data: tests

router.get '/get/:id/', (req, res) ->
    tests.get req.params.id, (test) ->
        if not test? then res.send error: 'Тест не знайдено!'
        else res.send data: test

router.post '/save/', (req, res) ->
    SaveError = error: 'Помилка створення тесту!'
    return res.send SaveError if req.body.name?.length < 1

    req.body.questions ?= []
    tests.save req.body, (saved) ->
        if not saved? then res.send SaveError
        else res.send saved

router.get '/delete/:id/', (req, res) ->
    tests.delete req.params.id, (result) ->
        res.send result

module.exports = router
