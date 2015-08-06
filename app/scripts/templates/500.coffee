React = require 'react'
{html, head, meta, title, body} = React.DOM


module.exports = React.createClass
  displayName: '500'

  render: ->
    html null,
      head null,
        meta
          charSet: 'utf-8'
        title null,
          '(500)'

      body null,
        @props.error
