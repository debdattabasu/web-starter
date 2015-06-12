HtmlWebpackPlugin = require 'html-webpack-plugin'
jade = require 'jade'
indexTemplate = jade.compileFile './client/index.jade'


module.exports =
  entry: "./client/app.coffee"
  output:
    path: "./build/web"
    filename: "bundle.js"

  module:
    loaders: [
      { test: /\.styl$/, loader: "style!css!stylus" }
      { test: /\.coffee$/, loader: "coffee" }
      { test: /\.jade$/, loader: "jade" }
    ]

  resolve:
    extensions: ['', '.js', '.coffee']

  plugins: [new HtmlWebpackPlugin { templateContent: indexTemplate() }]
