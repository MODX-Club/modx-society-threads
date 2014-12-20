ChatServerActionCreators = require "../actions/ChatServerActionCreators"
Request = require('../tools/request').init()
Helpers = require '../tools/helpers'

module.exports =
  getAllMessages: (resourceId)->
    promise = Request.run 'messages/getdata', {
      topicId:resourceId or Society.Topic.targetId
      limit:0
    }
    promise.then (args) ->
      if args.response.success
        ChatServerActionCreators.receiveAll args.response.object

    return

  createMessage: (message) ->
    p = Request
      .run 'message/create', message

    p.catch((e) ->
      Helpers.debug -> console.warn e.message;console.log e.stack
    )

    p.then (args) ->
      if args.response.success
        ChatServerActionCreators.didCreateMessage args.response.object

  shouldCommentVote:(id,dir=no) ->
    if dir
      dir = 'up'
    else
      dir = 'down'

    Request
      .run 'message/vote', {
        target_id:id
        vote_direction:dir
      }
      .then (args) ->
        if args.response.success
          ChatServerActionCreators.commentDidVote args.response.object
        else
          alert(args.response.message)
