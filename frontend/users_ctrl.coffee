UsersCtrl = ($scope, UsersService) ->
    $scope.initialized = no
    $scope.current = UsersService.current

    $scope.reload = ->
        UsersService.getAll().then (users) ->
            $scope.users = users.data
            $scope.initialized = yes

    $scope.setCurrent = (user) ->
        $scope.current = user
        UsersService.current = user

    $scope.delete = (id) ->
        UsersService.delete(id).then (res) ->
            $scope.reload()

    $scope.logout = ->
        UsersService.logout().then ->
            window.location.reload()

    $scope.canEdit = (user) ->
        return yes if $scope.current.admin
        return yes if user.id.toString() is $scope.current.id.toString()
        no

angular
    .module('app')
    .controller('UsersCtrl', ['$scope', 'UsersService', UsersCtrl])
