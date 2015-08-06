React = require 'react'
{html, head, title, meta, body, script} = React.DOM
{RouteHandler} = require 'react-router'
classnames = require 'classnames'

RouteHandler = React.createFactory RouteHandler
Link = React.createFactory Link
Navigation = React.createFactory require '../components/navigation'


module.exports =
React.createClass
  displayName: 'App'

  render: ->
    html null,
      head null,
        meta
          charSet: 'utf-8'
        title null,
          'Express React'

      body null,
        Navigation()

        # Render content based on route
        RouteHandler()

        if process.env.NODE_ENV is 'production' then [
          script
            key: 'main'
            src: "/vendor.js?#{process.env.BUILD_TIMESTAMP}"
          script
            key: 'vendor'
            src: "/main.js?#{process.env.BUILD_TIMESTAMP}"
        ]
        else
          script
            src: "http://localhost:8080/main.js"