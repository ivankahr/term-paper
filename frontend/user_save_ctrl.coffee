UserSaveCtrl = ($scope, $location, $routeParams, UsersService) ->
    $scope.id = $routeParams.id
    $scope.initialized = no
    $scope.current = UsersService.current

    if $scope.id?
        UsersService.get($scope.id).then (user) ->
            $scope.user = user.data
            $scope.initialized = yes
    else $scope.initialized = yes

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
