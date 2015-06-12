gulp = require 'gulp'
gutil = require 'gulp-util'
express = require 'express'
webpack = require 'webpack'
webpackConfig = require './webpack.config'
server = require './server/server'


webpackStatOptions =
  hash : false
  version : false
  chunks: false
  colors : true

runWebpack = (release, cb) ->
  myConfig = Object.create webpackConfig
  if release
    myConfig.plugins = myConfig.plugins.concat [
      new webpack.optimize.UglifyJsPlugin()
      new webpack.optimize.OccurenceOrderPlugin()
    ]
  webpack myConfig, (err, stats) ->
    if err then throw new gutil.PluginError 'webpack', err
    gutil.log 'webpack', stats.toString webpackStatOptions
    cb()


startExpress = (cb) ->
  app = express()
  app.use express.static 'build/web'
  server app
  handle = app.listen 8080, ->
    gutil.log 'express', 'server started at 8080'
    cb()


gulp.task 'build:release', (cb) -> runWebpack true, cb
gulp.task 'build:debug', (cb) -> runWebpack false, cb

gulp.task 'debug', ['build:debug'], (cb)-> startExpress cb
gulp.task 'release', ['build:release'], (cb)-> startExpress cb

gulp.task 'default', ['debug']
