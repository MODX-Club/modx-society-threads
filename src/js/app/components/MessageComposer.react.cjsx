React = require "react"
ChatMessageActionCreators = require "../actions/ChatMessageActionCreators"

ENTER_KEY_CODE = 13

MessageComposer = React.createClass
  getInitialState: ->
    text: ""

  render: ->
    Composer = (
      <div>
        <textarea
          rows=3
          name="message"
          value={this.state.text}
          onChange={@_onChange}
          onKeyDown={@_onKeyDown}
        />
        <div>
          <button
            onClick={@_sendMessage}
          >Написать комментарий
          </button>
        </div>
      </div>
    )

    (
      <div>
        {Composer if +Society.User.id isnt 0}
      </div>
    )

  _sendMessage:() ->
    text = @state.text.trim()
    ChatMessageActionCreators.createMessage text, {replyTo:@props.replyToId} if text
    @setState text: ""

  _onChange: (event, value) ->
    @setState text: event.target.value

  _onKeyDown: (event) ->
    if event.keyCode is ENTER_KEY_CODE
      event.preventDefault()
      @_sendMessage()

module.exports = MessageComposer
