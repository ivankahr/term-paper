db = require '../helpers/db'

module.exports = (query, params, cb) ->
    if typeof params is 'function'
        cb = params
        params = []

    db.query query, params, (err, res) ->
        if err?
            console.log err
            cb? null
        else cb? res
