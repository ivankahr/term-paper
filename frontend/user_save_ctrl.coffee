UserSaveCtrl = ($scope, $location, $routeParams, UsersService) ->
    $scope.id = $routeParams.id
    $scope.initialized = no

    if $scope.id? then UsersService.get($scope.id).then (user) ->
        $scope.user = user.data
        $scope.initialized = yes

    $scope.delete = ->
        UsersService.delete(id).then (res) ->
            $location.path '/'

    $scope.save = ->
        UsersService.save($scope.user).then (res) ->
            $location.path '/'

angular
    .module('app')
    .controller('UserSaveCtrl', [
        '$scope'
        '$location'
        '$routeParams'
        'UsersService'
        UserSaveCtrl
    ])
