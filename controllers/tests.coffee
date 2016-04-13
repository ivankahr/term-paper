express = require 'express'
router = express.Router()
tests = require '../models/tests'

router.get '/', (req, res) ->
    tests.getAll (tests) ->
        if not tests? then res.render 'error', msg: 'Помилка вибірки тестів!'
        res.render 'tests', tests: tests

router.get '/new/', (req, res) ->
    res.render 'test_new'

router.post '/new/', (req, res) ->
    SaveError =
        msg: 'Помилка створення тесту!'
        link:
            title: 'Повторити введення'
            href: '/tests/new/'
    return res.render 'error', SaveError if req.body.name?.length < 1

    req.body.questions ?= []
    tests.save req.body, (saved) ->
        if not saved? then res.render 'error', SaveError
        else res.redirect '/tests/'

router.get '/delete/:id/', (req, res) ->
    tests.delete req.params.id, (result) ->
        res.redirect '/tests/'

module.exports = router
