ResultsService = ($http) ->
    getByUser: (uid) ->
        $http.get("/api/results/get_by_user/#{uid}")
            .then (res) ->
                res.data

    save: (result) ->
        $http.post('/api/results/save/', result)
            .then (res) ->
                res.data

angular
    .module('app')
    .service('ResultsService', ResultsService)
