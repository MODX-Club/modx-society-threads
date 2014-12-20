ChatAppDispatcher = require "../dispatcher/ChatAppDispatcher"
ChatConstants = require "../constants/ChatConstants"
ActionTypes = ChatConstants.ActionTypes

module.exports =
  receiveAll: (rawMessages) ->
    ChatAppDispatcher.handleServerAction
      type: ActionTypes.RECEIVE_RAW_MESSAGES
      rawMessages: rawMessages

  didCreateMessage: (createdMessage) ->
    ChatAppDispatcher.handleServerAction
      type: ActionTypes.RECEIVE_RAW_CREATED_MESSAGE
      rawMessage: createdMessage

  commentDidVote: (response) ->
    ChatAppDispatcher.handleServerAction
      type: ActionTypes.COMMENT_DID_VOTE
      data: response
