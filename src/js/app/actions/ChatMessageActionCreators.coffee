ChatAppDispatcher = require '../dispatcher/ChatAppDispatcher'
ChatConstants = require '../constants/ChatConstants'
ChatWebAPIUtils = require '../utils/ChatWebAPIUtils'
ChatMessageUtils = require '../utils/ChatMessageUtils'

ActionTypes = ChatConstants.ActionTypes

module.exports =
  createMessage: (text, options={}) ->
    ChatWebAPIUtils.createMessage(
      ChatMessageUtils.prepareCreatedMessage text, options
    )

  shouldCommentVote: ->
    ChatWebAPIUtils.shouldCommentVote.apply null,arguments
