require('dotenv').load()

webpack = require 'webpack'


module.exports =
  entry: [
      'webpack-dev-server/client?http://localhost:8080'
      'webpack/hot/only-dev-server'
      "#{__dirname}/app/scripts/main.coffee"
  ]
  output:
    path: "#{__dirname}/app/public"
    filename: 'main.js'
    publicPath: 'http://localhost:8080/'
  resolve:
    extensions: ['', '.coffee', '.js']
  resolveLoader:
    modulesDirectories: ['node_modules']
  plugins: [
    new webpack.DefinePlugin
      GA_TRACKING_CODE: JSON.stringify(process.env.ANALYTICS)
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ]
  module:
    loaders: [
      {
        test: /\.coffee$/
        loaders: ['react-hot', 'envify-loader', 'coffee']
      }
      {
        test: /\.less$/
        loaders: ['style-loader', 'css-loader', 'less-loader']
      }
      {
        test: /\.(svg)$/,
        loader: 'raw-loader'
      }
      {
        test: /\.(json)$/,
        loader: 'json-loader'
      }
    ]
    noParse: /\.min\.js/
