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

        .when '/tests/',
            templateUrl: '/views/tests.html'
            controller: 'TestsCtrl'

        .when '/tests/edit/:id',
            templateUrl: '/views/test_save.html'
            controller: 'TestSaveCtrl'

        .when '/tests/add',
            templateUrl: '/views/test_save.html'
            controller: 'TestSaveCtrl'

        .when '/tests/:id',
            templateUrl: '/views/test.html'
            controller: 'TestCtrl'

angular.module('app').config routes
