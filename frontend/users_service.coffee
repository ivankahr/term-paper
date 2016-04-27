UsersService = ($http, $q) ->
    getAll: ->
        $http.get('/api/users/get/')
            .then (res) ->
                res.data

    get: (id) ->
        if @current.id.toString() is id.toString()
            user = {}
            user[key] = @current[key] for key of @current
            $q (cb, _) -> cb data: user
        else
            $http.get("/api/users/get/#{id}")
                .then (res) ->
                    res.data

    save: (user) ->
        if user.id.toString() is @current.id.toString()
            @current[key] = user[key] for key of user

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
