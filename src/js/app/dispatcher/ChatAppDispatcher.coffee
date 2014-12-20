ChatConstants = require "../constants/ChatConstants"
Dispatcher = require("flux").Dispatcher

# assign = require "object-assign"
assign = require "../../../../node_modules/react/lib/Object.assign"

PayloadSources = ChatConstants.PayloadSources

ChatAppDispatcher = assign new Dispatcher(),

  _handleAction:(action, source) ->
    payload = {source,action}
    @dispatch payload
    return

  handleServerAction: (action) ->
    @_handleAction action, PayloadSources.SERVER_ACTION

  handleViewAction: (action) ->
    @_handleAction action, PayloadSources.SERVER_ACTION

module.exports = ChatAppDispatcher
