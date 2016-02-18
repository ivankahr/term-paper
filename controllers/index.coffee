express = require 'express'
router = express.Router()
users = require '../models/users'

router.use '/users', require './users'
router.get '/', (req, res) ->
    users.getAll (users) ->
        if not users? then res.render 'error'
        else res.render 'index', users: users

module.exports = router
