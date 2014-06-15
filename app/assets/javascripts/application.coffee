#= require d3
#= require angular
#= require angular-touch
#= require angular-route
#= require angular-rails-templates
#= require_tree ../templates
#= require_self
#= require_tree .


angular.module('mustache', ['ngTouch', 'ngRoute', 'templates']).

config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
  $routeProvider.
    when('/users',      templateUrl: 'users.html',   controller: 'UsersCtrl').
    otherwise(          redirectTo: '/users')
])
