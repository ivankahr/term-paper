UserCtrl = ($scope, $location, $routeParams, UsersService, ResultsService) ->
    $scope.id = $routeParams.id
    $scope.initialized = no

    UsersService.get($scope.id).then (user) ->
        $scope.user = user.data
        $scope.initialized = yes

    ResultsService.getByUser($scope.id).then (results) ->
        $scope.results = results.data

    $scope.delete = ->
        UsersService.delete(id).then (res) ->
            $location.path '/'

angular
    .module('app')
    .controller 'UserCtrl', [
        '$scope'
        '$location'
        '$routeParams'
        'UsersService'
        'ResultsService'
        UserCtrl
    ]
