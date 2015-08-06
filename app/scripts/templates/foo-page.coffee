React = require 'react'
{h1} = React.DOM


module.exports =
React.createClass
  displayName: 'FooPage'

  render: ->
    h1 null,
      'Foo Page'
