webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
config = require './webpack.config'

host = 'localhost'
port = 8080


server = new WebpackDevServer webpack(config),
  publicPath: config.output.publicPath
  hot: true
  historyApiFallback: true

server.listen 8080, 'localhost', (err, result) ->
  console.err err if err

  console.log("Listening at #{host}:#{port}")
