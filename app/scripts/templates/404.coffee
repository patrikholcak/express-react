React = require 'react'
{h1} = React.DOM
{Link} = require 'react-router'


module.exports = React.createClass
  displayName: 'NotFound'

  render: ->
    h1 null,
      '404'
