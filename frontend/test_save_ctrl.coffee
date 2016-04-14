TestSaveCtrl = ($scope, $location, $routeParams, TestsService) ->
    $scope.id = $routeParams.id

    if $scope.id? then TestsService.get($scope.id).then (test) ->
        $scope.test = test.data
    else $scope.test = questions: [answers: [correct: no]]

    $scope.delete = ->
        TestsService.delete(id).then (res) ->
            $location.path '/'

    $scope.addQuestion = ->
        $scope.test.questions.push answers: [correct: no]

    $scope.addAnswer = (index) ->
        $scope.test.questions[index].answers.push correct: no

    $scope.save = ->
        TestsService.save($scope.test).then (res) ->
            $location.path '/tests/'

    $scope

angular
    .module('app')
    .controller('TestSaveCtrl', [
        '$scope'
        '$location'
        '$routeParams'
        'TestsService'
        TestSaveCtrl
    ])
