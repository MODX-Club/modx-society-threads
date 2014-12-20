React = require "react"
MessageListItem = require "./MessageListItem.react"
MessageStore = require "../stores/MessageStore"

ReactPropTypes = React.PropTypes

getStateFromStores =
  ->
    messages: MessageStore.getAll()

MessageTreeListItem = React.createClass

  propTypes:
    message: ReactPropTypes.object

  getInitialState:(args) ->
    getStateFromStores()

  render: ->
    messages = @props.Items
    (
      <div>
      {
        for k,v of messages
          @_getNode k,v if v.parent is null
      }
      </div>
    )

  _getNode:(key,message) ->
    edit = yes if @props.editingNode is message.id

    (
      <li key="section-#{key}">
        <MessageListItem
          message={message}
          edit={edit}
          replyTo={@props.replyTo.bind(null,message)}
        />
        <ul className="messageList">
          {@_getChildNodes message.childs}
        </ul>
      </li>
    )

  _getChildNodes:(ids) ->
    if ids.length then ids.map((key,i) ->
      @_getNode key, @state.messages[key]
    ,@)


module.exports = MessageTreeListItem
