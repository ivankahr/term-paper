express = require 'express'
router = express.Router()
results = require '../models/results'

router.get '/get_by_user/:uid/', (req, res) ->
    results.getByUser req.params.uid, (data) ->
        if not data? then res.send error: 'Результатів не знайдено!'
        else res.send data: data

router.post '/save/', (req, res) ->
    SaveError = error: 'Помилка збереження результату!'
    return res.send SaveError if req.body.length < 1

    results.save req.session.uid, req.body, (saved) ->
        if not saved? then res.send SaveError
        else res.send saved

module.exports = router
