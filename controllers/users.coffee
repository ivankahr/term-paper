express = require 'express'
router = express.Router()
users = require '../models/users'

router.get '/new/', (req, res) ->
    res.render 'user_new'

router.post '/new/', (req, res) ->
    SaveError =
        msg: 'Помилка створення користувача!'
        link:
            title: 'Повторити введення'
            href: '/users/new/'
    return res.render 'error', SaveError if req.body.name?.length < 1

    users.new req.body.name, (saved) ->
        if not saved? then res.render 'error', SaveError
        else res.redirect "/users/#{saved.insertId}"

router.get '/:id/', (req, res) ->
    users.get req.params.id, (user) ->
        if not user? then res.render 'error', msg: 'Користувача не знайдено!'
        else res.render 'user', user: user

router.get '/delete/:id/', (req, res) ->
    users.delete req.params.id, (result) ->
        res.redirect '/'

module.exports = router
