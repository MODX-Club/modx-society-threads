ChatAppDispatcher = require "../dispatcher/ChatAppDispatcher"
ChatConstants = require "../constants/ChatConstants"
ChatMessageUtils = require "../utils/ChatMessageUtils"
EventEmitter = require("events").EventEmitter
ThreadStore = require "../stores/ThreadStore"
StoreMixin = require '../mixins/StoreMixin'
assign = require "../../../../node_modules/react/lib/Object.assign"

ActionTypes = ChatConstants.ActionTypes

_messages = {}

_addMessage = (rawMessage) ->
  message = ChatMessageUtils.convertRawMessage rawMessage
  if !_messages[message.id]
    _messages[message.id] = message


_addMessages = (rawMessages) ->
  rawMessages.forEach (message) ->
    _addMessage message


MessageStore = assign {}, EventEmitter::,

  get: (id) ->
    _messages[id]

  getAll: ->
    _messages

  updateParentChildNodes:(node) ->
    if node.parent?
      _messages[node.parent].childs.push node.id

  getCount: ->
    Object.keys(_messages).length

  _resetEditState:(id) ->
    _messages.map (item, i, list) ->
      item.edit = no

    _messages[id].edit = yes

MessageStore = assign MessageStore, StoreMixin
MessageStore.dispatchToken = ChatAppDispatcher.register((payload) ->
  action = payload.action

  switch action.type
    when ActionTypes.CREATE_MESSAGE
      message = ChatMessageUtils.prepareCreatedMessage action.text
      _messages[message.id] = message

    when ActionTypes.RECEIVE_RAW_MESSAGES
      ChatAppDispatcher.waitFor [ThreadStore.dispatchToken]
      _addMessages action.rawMessages

    when ActionTypes.RECEIVE_RAW_CREATED_MESSAGE
      ChatAppDispatcher.waitFor [ThreadStore.dispatchToken]
      _addMessage action.rawMessage
      MessageStore.updateParentChildNodes action.rawMessage

    when ActionTypes.COMMENT_DID_VOTE
      _messages[action.data.target_id].rating = Math.round action.data.rating

    else

  MessageStore.emitChange()
)

module.exports = MessageStore
