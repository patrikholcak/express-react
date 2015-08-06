React = require 'react'

ErrorPage = require './scripts/templates/500'


module.exports = (err, req, res, next) ->
  element = React.createElement(ErrorPage, error: err.stack)
  content = React.renderToStaticMarkup(element)

  # Render error page
  res.status(500)
  res.write('<!doctype html>\n')
  res.write(content)
  res.end()

  next(err)

  return
