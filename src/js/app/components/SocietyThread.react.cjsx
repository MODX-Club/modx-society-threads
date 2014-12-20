React = require 'react'
ThreadSection = require './ThreadSection.react'
MessageSection = require './MessageSection.react'

ChatApp = React.createClass
  render: (args) ->
    (
      <div className="threadApp">
        <ThreadSection />
        <MessageSection />
      </div>
    )

module.exports = ChatApp
