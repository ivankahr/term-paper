UsersCtrl = ($scope, UsersService) ->
    $scope.reload = ->
        UsersService.getAll().then (users) ->
            $scope.users = users.data

    $scope.delete = (id) ->
        UsersService.delete(id).then (res) ->
            $scope.reload()

    $scope.logout = ->
        UsersService.logout().then ->
            window.location.reload()

angular
    .module('app')
    .controller('UsersCtrl', ['$scope', 'UsersService', UsersCtrl])
