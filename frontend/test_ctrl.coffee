TestCtrl = ($scope, $location, $routeParams, TestsService) ->
    $scope.id = $routeParams.id
    $scope.checked = no

    TestsService.get($scope.id).then (test) ->
        $scope.test = test.data

    $scope.check = ->
        for question in $scope.test.questions
            question.correct = no
            for answer in question.answers
                if question.answer is answer.id
                    question.correct = yes if answer.correct
                    break
        $scope.checked = yes

angular
    .module('app')
    .controller('TestCtrl', ['$scope', '$location', '$routeParams', 'TestsService', TestCtrl])
