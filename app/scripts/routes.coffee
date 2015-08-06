React = require 'react'
{Route, DefaultRoute, Redirect, NotFoundRoute} = Router = require 'react-router'

Route = React.createFactory Route
DefaultRoute = React.createFactory DefaultRoute
Redirect = React.createFactory Redirect
NotFoundRoute = React.createFactory NotFoundRoute


module.exports =
Route
  handler: require './templates/_base'
  path: '/'
  name: 'foo'

  DefaultRoute
    handler: require './templates/foo-page'

  Route
    name: 'bar'
    handler: require './templates/bar-page'

  Redirect
    from: '/baz'
    to: 'bar'

  NotFoundRoute
    handler: require './templates/404'
    name: 'not-found'
