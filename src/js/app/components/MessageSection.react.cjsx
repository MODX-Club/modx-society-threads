React = require "react"
MessageComposer = require "./MessageComposer.react"
MessageTreeListItem = require "./MessageTreeListItem.react"

MessageStore = require "../stores/MessageStore"
ThreadStore = require "../stores/ThreadStore"
MessageThreadChangeMixin = require '../mixins/MessageThreadChangeMixin'

getStateFromStores =
  ->
    messages: MessageStore.getAll()
    thread: ThreadStore.getCurrent()
    editingNode:no

MessageSection = React.createClass
  mixins:[MessageThreadChangeMixin]

  getInitialState: ->
    getStateFromStores()

  render: ->
    (
      <section className="messageSection">
        <ul className="messageList">
          <MessageTreeListItem
            Items={@state.messages}
            replyTo={@_replyToNode}
            editingNode={@state.editingNode}
          />
        </ul>
        {if !@state.editingNode
          <MessageComposer />
        }
      </section>
    )

  _replyToNode:(r) ->
    @setState
      editingNode:r.id

  _onChange: ->
    @setState getStateFromStores()

module.exports = MessageSection
