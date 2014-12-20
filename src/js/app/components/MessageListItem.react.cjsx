React = require "react"
MessageComposer = require "./MessageComposer.react"
ChatMessageActionCreators = require "../actions/ChatMessageActionCreators"

ReactPropTypes = React.PropTypes

MessageListItem = React.createClass
  propTypes:
    message: ReactPropTypes.object

  render: ->
    message = @props.message
    area = <MessageComposer replyToId={message.id} /> if @props.edit
    (
      <div>
        <div>
          <a href="javascript:void(0)">
            {message.authorName}
          </a>
          <span>|</span>
          <small>{message.date.toLocaleDateString()}{message.date.toLocaleTimeString()}</small>
          <span>|</span>
          <span>
            <a
              href="javascript:void(0)"
              style={{textDecoration:'none'}}
              onClick={@_handleVoteDown}
            >↓
            </a>
            <span>{message.rating or 0}</span>
            <a
              style={{textDecoration:'none'}}
              href="javascript:void(0)"
              onClick={@_handleVoteUp}
            >↑
            </a>
          </span>
        </div>
        <div>
          {message.text}
        </div>
        <div>
          <a
            href="javascript:void(0)"
            onClick={@props.replyTo}
          >Ответить</a>
        </div>
        <div>{area or no}</div>
      </div>
    )

  _handleVoteUp:->
    ChatMessageActionCreators.shouldCommentVote @props.message.id,yes

  _handleVoteDown:->
    ChatMessageActionCreators.shouldCommentVote @props.message.id

module.exports = MessageListItem
