express = require 'express'
router = express.Router()
users = require '../models/users'

router.post '/save/', (req, res) ->
    SaveError = error: 'Помилка створення користувача!'
    return res.send SaveError if req.body.name?.length < 1

    users.save req.body, (saved) ->
        if not saved? then res.send SaveError
        else res.send saved

router.get '/get/', (req, res) ->
    users.getAll (users) ->
        if not users? then res.send error: 'Користувачів не знайдено!'
        else res.send data: users

router.get '/get/:id/', (req, res) ->
    users.get req.params.id, (user) ->
        if not user? then res.send error: 'Користувача не знайдено!'
        else res.send data: user

router.get '/delete/:id/', (req, res) ->
    users.delete req.params.id, (result) ->
        res.send result

router.post '/login/', (req, res) ->
    users.getByName req.body.name, (user) ->
        req.session.uid = user.id if user?
        res.redirect '/'

router.get '/logout/', (req, res) ->
    delete req.session.uid
    res.send data: yes

module.exports = router
