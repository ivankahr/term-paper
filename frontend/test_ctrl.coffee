TestCtrl = ($scope
        $location, $routeParams, TestsService, ResultsService) ->
    $scope.id = $routeParams.id
    $scope.checked = no
    $scope.initialized = no

    TestsService.get($scope.id).then (test) ->
        $scope.test = test.data
        $scope.initialized = yes

    $scope.check = ->
        result = []
        for question in $scope.test.questions
            result.push answer_id: question.answer
            return if not question.answer?

            question.correct = no
            for answer in question.answers
                if question.answer is answer.id
                    question.correct = yes if answer.correct
                    break

        $scope.checked = yes
        ResultsService.save(result)

angular
    .module('app')
    .controller 'TestCtrl', [
        '$scope'
        '$location'
        '$routeParams'
        'TestsService'
        'ResultsService'
        TestCtrl
    ]
