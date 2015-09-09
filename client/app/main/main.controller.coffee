'use strict'

angular.module 'toaApp'
.controller 'MainCtrl', ($scope, $http, socket, Auth) ->
  $scope.awesomeThings = []
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings
    socket.syncUpdates 'thing', $scope.awesomeThings
  
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
      ip : $scope.getCurrentUser().email
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
#setup filter    
.filter 'loggedinUser', (Auth)  ->
  # Create the return function and set the required parameter name to **input**
  (input) ->
    out = []
    # Using the angular.forEach method, go through the array of data and perform the operation of figuring out if the language is statically or dynamically typed.
    angular.forEach input, (thing) ->
      if thing.ip == Auth.getCurrentUser().email
        out.push thing
      return
    out


