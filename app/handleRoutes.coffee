React = require 'react'
Router = require 'react-router'
_ = require 'lodash'

routes = require './scripts/routes'


module.exports = (req, res) ->
  router = Router.create
    routes: routes
    location: req.path

    # Handle redirects
    onAbort: (redirect) ->
      {to, params, query} = redirect
      url = router.makePath(to, params, query)
      res.redirect 301, url

    # Handle routing errors
    onError: (err) ->
      console.error "\x1b[31m[server] \x1b[0m Routing Error"
      console.error err
      next(err)

  # Run react router to render the app
  router.run (Handler, state) ->
    App = React.createElement(Handler, state)

    # Send 404 status if the resource wasn’t found
    res.status(404) if _.findKey(state.routes, 'isNotFound', true)

    # Render the content
    res.write('<!doctype html>\n')
    res.write(React.renderToString(App))
    res.end()

    return
