React = require 'react'
{h1} = React.DOM


module.exports =
React.createClass
  displayName: 'BarPage'

  render: ->
    h1 null,
      'Bar Page'
