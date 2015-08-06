require('../styles/main.less') unless process.env.__PROD__

React = require 'react'
Router = require 'react-router'
# analytics = require 'ga-react-router'

routes = require './routes'


# Render the App
Router.run routes, Router.HistoryLocation, (Handler, state) ->
  React.render(React.createElement(Handler, state), document)
  analytics?(state)
