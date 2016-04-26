TestSaveCtrl = ($scope, $location, $routeParams, TestsService) ->
    $scope.id = $routeParams.id

    if $scope.id? then TestsService.get($scope.id).then (test) ->
        $scope.test = test.data

        for question in $scope.test.questions
            for answer, i in question.answers
                if answer.correct
                    question.answer = i
                    break

    else $scope.test = questions: [answers: [correct: no]]

    $scope.delete = ->
        TestsService.delete(id).then (res) ->
            $location.path '/'

    $scope.addQuestion = ->
        $scope.test.questions.push answers: [correct: no]

    $scope.removeQuestion = (index) ->
        $scope.test.questions.splice(index, 1)

    $scope.removeAnswer = (questionIndex, index) ->
        $scope.test.questions[questionIndex].answers.splice(index, 1)

    $scope.addAnswer = (index) ->
        $scope.test.questions[index].answers.push correct: no

    $scope.save = ->
        for question in $scope.test.questions
            for answer, i in question.answers
                if i is question.answer then answer.correct = yes
                else answer.correct = no

        TestsService.save($scope.test).then (res) ->
            $location.path '/tests/'

angular
    .module('app')
    .controller('TestSaveCtrl', [
        '$scope'
        '$location'
        '$routeParams'
        'TestsService'
        TestSaveCtrl
    ])
