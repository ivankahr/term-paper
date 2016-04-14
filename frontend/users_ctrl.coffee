UsersCtrl = ($scope, UsersService) ->
    UsersService.getAll().then (users) ->
        $scope.users = users.data
    $scope

angular
    .module('app')
    .controller('UsersCtrl', ['$scope', 'UsersService', UsersCtrl])
