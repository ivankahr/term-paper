express = require 'express'
router = express.Router()
users = require '../models/users'

router.use '/users', require './users'
router.use '/tests', require './tests'

router.get '/', (req, res) ->
    users.getAll (users) ->
        if not users? then res.render 'error'
        else res.render 'users', users: users

module.exports = router
