angular = require 'angular'
registerDirectives = require './directives/register'

app = angular.module 'app', []

registerDirectives app
