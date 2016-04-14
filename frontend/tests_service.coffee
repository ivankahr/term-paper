TestsService = ($http) ->
    getAll: ->
        $http.get('/api/tests/get/')
            .then (res) ->
                res.data

    get: (id) ->
        $http.get("/api/tests/get/#{id}")
            .then (res) ->
                res.data

    save: (test) ->
        $http.post('/api/tests/save/', test)
            .then (res) ->
                res.data

    delete: (id) ->
        $http.get("/api/tests/delete/#{id}")
            .then (res) ->
                res.data

angular
    .module('app')
    .service('TestsService', TestsService)
