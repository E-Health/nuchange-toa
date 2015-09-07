'use strict'

angular.module 'toaApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.awesomeThings = []

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

    $scope.newThing = ''

  $scope.deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id

  $scope.editThing = (thing) ->
    $http.put '/api/things/' + thing._id

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'thing'
