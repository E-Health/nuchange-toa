'use strict'

angular.module 'toaApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.awesomeThings = []

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings
    socket.syncUpdates 'thing', $scope.awesomeThings
  $http.get('/api/things/ip/ip').success (clientIp) ->
    $scope.newIp = clientIp.ip
  
  $scope.addThing = ->
    return if $scope.newName is ''
    $http.post '/api/things',
      name: $scope.newName
      identifier: $scope.newIdentifier
      avtar: $scope.newAvtar
      dob: $scope.newDob
      datet: $scope.newDatet
      mrp: $scope.newMrp
      nurse: $scope.newNurse
      story: $scope.newStory
      assessment: $scope.newAssessment
      followup: $scope.newFollowup
      evaluation: $scope.newEvaluation
      ip : $scope.newIp
    $scope.newName = ''
    $scope.newIdentifier = ''
    $scope.newAvtar = ''
    $scope.newDob = ''
    $scope.newDatet = ''
    $scope.newMrp = ''
    $scope.newNurse = ''
    $scope.newStory = ''
    $scope.newAssessment = ''
    $scope.newFollowup = ''
    $scope.newEvaluation = ''

  $scope.deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id

  $scope.editThing = (thing) ->
    $http.get('/api/things/' + thing._id).success (awesomeThing) ->
      $scope.newName = awesomeThing.name
      $scope.newIdentifier = awesomeThing.identifier
      $scope.newAvtar = awesomeThing.avtar
      $scope.newDob = awesomeThing.dob
      $scope.newDatet = awesomeThing.datet
      $scope.newMrp = awesomeThing.mrp
      $scope.newNurse = awesomeThing.nurse
      $scope.newStory = awesomeThing.story
      $scope.newAssessment = awesomeThing.assessment
      $scope.newFollowup = awesomeThing.followup
    $http.delete '/api/things/' + thing._id

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'thing'
