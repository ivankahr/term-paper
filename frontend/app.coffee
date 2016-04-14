angular.module 'app', ['ngRoute']

routes = ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode yes
    $routeProvider
        .when '/',
            templateUrl: '/views/users.html'
            controller: 'UsersCtrl'

        .when '/users/edit/:id',
            templateUrl: '/views/user_save.html'
            controller: 'UserSaveCtrl'

        .when '/users/add/',
            templateUrl: '/views/user_save.html'
            controller: 'UserSaveCtrl'

        .when '/users/:id',
            templateUrl: '/views/user.html'
            controller: 'UserCtrl'

angular.module('app').config routes
