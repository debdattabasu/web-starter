template = require './MainApplication.jade'

MainApplicationController = ($scope) ->
  $scope.name = 'Hello World'

MainApplicationController.$inject = ['$scope']

MainApplicationDirective = ->
  restrict: 'E'
  scope: {}
  controller: MainApplicationController
  template : template()

module.exports = MainApplicationDirective
