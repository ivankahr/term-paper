angular.module 'app', ['ngRoute']

routes = ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode yes
    $routeProvider
        .when '/',
            templateUrl: '/views/users.html'
            controller: 'UsersCtrl'

angular.module('app').config routes
