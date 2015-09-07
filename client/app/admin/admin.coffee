'use strict'

angular.module 'toaApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/admin',
    templateUrl: 'app/admin/admin.html'
    controller: 'AdminCtrl'
