UserCtrl = ($scope, $location, $routeParams, UsersService) ->
    $scope.id = $routeParams.id

    UsersService.get($scope.id).then (user) ->
        $scope.user = user.data

    $scope.delete = ->
        UsersService.delete(id).then (res) ->
            $location.path '/'

    $scope

angular
    .module('app')
    .controller('UserCtrl', ['$scope', '$location', '$routeParams', 'UsersService', UserCtrl])
