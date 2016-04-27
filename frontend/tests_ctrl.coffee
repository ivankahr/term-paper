TestsCtrl = ($scope, TestsService) ->
    $scope.initialized = no

    $scope.reload = ->
        TestsService.getAll().then (tests) ->
            $scope.tests = tests.data
            $scope.initialized = yes

    $scope.delete = (id) ->
        TestsService.delete(id).then (res) ->
            $scope.reload()

    $scope.reload()

angular
    .module('app')
    .controller('TestsCtrl', ['$scope', 'TestsService', TestsCtrl])
