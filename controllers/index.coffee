express = require 'express'
router = express.Router()
users = require '../models/users'

router.use '/users', require './users'
router.use '/tests', require './tests'

module.exports = router
