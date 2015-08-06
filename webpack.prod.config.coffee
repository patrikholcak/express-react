require('dotenv').load()

webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'
fs = require 'fs'
process.env.BUILD_TIMESTAMP = +new Date()


# Write build timestamp
fs.readFile './.env', 'utf8', (err, data) ->
  return if err

  stamp = "BUILD_TIMESTAMP=#{process.env.BUILD_TIMESTAMP}"
  oldStamp = data.match(/BUILD_TIMESTAMP=[a-zA-Z0-9]{13}/)
  content = data.split('\n')
  index = content.indexOf(oldStamp[0]) if oldStamp

  if index >= 0
    content[index] = stamp
    fs.writeFile('.env', content.join('\n'))
  else
    fs.appendFile('.env', "\n#{stamp}")


module.exports =
  devtool: 'module-source-map'
  entry:
    'main': './app/scripts/main.coffee'
    'vendor': [
      'react'
      'react-router'
      'classnames'
      'ga-react-router'
    ]
  output:
    path: "./app/public"
    filename: 'main.js'
    publicPath: 'http://localhost:8080/'
  resolve:
    extensions: ['', '.coffee', '.js']
  resolveLoader:
    modulesDirectories: ['node_modules']
  plugins: [
    new webpack.DefinePlugin
      GA_TRACKING_CODE: JSON.stringify(process.env.ANALYTICS)
      __PROD__: "true"
    new webpack.optimize.CommonsChunkPlugin('vendor', 'vendor.js')
    new ExtractTextPlugin('main.css')
    new webpack.optimize.UglifyJsPlugin
      mangle:
        toplevel: true
      warnings: true
      compress:
        sequences: true
        dead_code: true
        conditionals: true
        booleans: true
        unused: true
        if_return: true
        join_vars: true
        drop_console: true
  ]
  module:
    loaders: [
      {
        test: /\.coffee$/
        loaders: ['source-map-loader', 'envify-loader', 'coffee']
      }
      {
        test: /\.less$/
        loader: ExtractTextPlugin.extract("css-loader!autoprefixer-loader?browsers=last 2 versions!less-loader")
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
