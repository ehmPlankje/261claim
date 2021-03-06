"use strict"
var app = angular.module('app');

app.factory('AuthService', function($http, $rootScope) {
  var user = {
    model: {}
  }
  return {
    login: function(credentials) {
      return $http.post('/api/user/login', credentials);
    },
    logout: function(credentials) {  
      return $http.post('/api/user/logout', credentials);
    },
    create: function(credentials) {
      return $http.put('/api/user/create', credentials);
    },
    isLoggedIn: function() {
      return !!user.model;
    }, 
    user: user,
    refresh: function() {
      $http.get('/api/user/refresh').then(
        function(response) {
          user.model = response.data.results;
          if(user.model) {
            $rootScope.$broadcast('USER_SIGNIN');
          }
        }, 
        function(response) {
          user.model = {};
        }
      );
    }
  };
});