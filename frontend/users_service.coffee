UsersService = ($http) ->
    getAll: ->
        $http.get('/api/users/get/')
            .then (res) ->
                res.data

    get: (id) ->
        $http.get("/api/users/get/#{id}")
            .then (res) ->
                res.data

    save: (user) ->
        $http.post('/api/users/save/', user)
            .then (res) ->
                res.data

    delete: (id) ->
        $http.get("/api/users/delete/#{id}")
            .then (res) ->
                res.data

    logout: ->
        $http.get('/api/users/logout/')
            .then (res) ->
                res.data

angular
    .module('app')
    .service('UsersService', UsersService)
