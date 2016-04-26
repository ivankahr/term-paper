TestsCtrl = ($scope, TestsService) ->
    $scope.reload = ->
        TestsService.getAll().then (tests) ->
            $scope.tests = tests.data

    $scope.delete = (id) ->
        TestsService.delete(id).then (res) ->
            $scope.reload()

    $scope.reload()

angular
    .module('app')
    .controller('TestsCtrl', ['$scope', 'TestsService', TestsCtrl])
