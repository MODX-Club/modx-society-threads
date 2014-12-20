ChatAppDispatcher = require "../dispatcher/ChatAppDispatcher"
ChatConstants = require "../constants/ChatConstants"
ChatMessageUtils = require "../utils/ChatMessageUtils"
EventEmitter = require("events").EventEmitter
StoreMixin = require '../mixins/StoreMixin'
assign = require "../../../../node_modules/react/lib/Object.assign"

ActionTypes = ChatConstants.ActionTypes

_currentId = null
_threads = {}

ThreadStore = assign {}, EventEmitter::,

  init: (rawMessages) ->
    rawMessages.forEach((message) ->
      @_addThread message.thread_id
    ,@)

  get: (id) ->
    _threads[id]

  getAll: ->
    _threads

  getCurrentId: ->
    _currentId

  getCurrent: ->
    @get @getCurrentId()

  _addThread:(tid) ->
    thread = _threads[tid]

    if !thread
      _threads[tid] =
        id: tid

      _currentId = tid


ThreadStore = assign ThreadStore, StoreMixin
ThreadStore.dispatchToken = ChatAppDispatcher.register (payload) ->
  action = payload.action

  switch action.type
    when ActionTypes.RECEIVE_RAW_MESSAGES
      ThreadStore.init action.rawMessages

    when ActionTypes.RECEIVE_RAW_CREATED_MESSAGE
      ThreadStore._addThread action.rawMessage.thread_id

    else

  ThreadStore.emitChange()



module.exports = ThreadStore
