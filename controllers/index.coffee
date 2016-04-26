express = require 'express'
router = express.Router()
users = require '../models/users'

router.use '/users', require './users'
router.use '/tests', require './tests'
router.use '/results', require './results'

module.exports = router
