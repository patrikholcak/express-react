React = require 'react'
{nav} = React.DOM
{Link} = require 'react-router'

Link = React.createFactory Link

module.exports = React.createClass
  displayName: 'Navigation'

  render: ->
    nav null,
      Link
        to: 'foo'
        'Foo page'

      Link
        to: 'bar'
        'Bar page'
