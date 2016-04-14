TestCtrl = ($scope, $location, $routeParams, TestsService) ->
    $scope.id = $routeParams.id

    TestsService.get($scope.id).then (test) ->
        $scope.test = test.data

    $scope.delete = ->
        TestsService.delete(id).then (res) ->
            $location.path '/'

    $scope

angular
    .module('app')
    .controller('TestCtrl', ['$scope', '$location', '$routeParams', 'TestsService', TestCtrl])
