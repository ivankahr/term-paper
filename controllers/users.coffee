express = require 'express'
router = express.Router()
users = require '../models/users'

router.get '/new/', (req, res) ->
    res.render 'user_new'

router.post '/new/', (req, res) ->
    users.new req.body.name, (saved) ->
        if not saved? then res.render 'error',
            msg: 'Помилка створення користувача!'
            link:
                title: 'Повторити введення'
                href: '/users/new/'
        else res.redirect "/users/#{saved.insertId}"

router.get '/:id/', (req, res) ->
    users.get req.params.id, (user) ->
        if not user? then res.render 'error'
        else res.render 'user', user: user

module.exports = router
